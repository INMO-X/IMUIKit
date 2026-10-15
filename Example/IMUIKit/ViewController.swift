import IMUIKit
import UIKit

/// 按 USAGE 走通弹窗、Toast 图标和返回按钮。图标来自 IMUIKit.bundle。
final class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private let resourceNames = ["ToastSuccess", "ToastFailure", "ToastInfo", "ToastLoading", "ArrowLeft", "Album"]
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "IMUIKit"
        view.backgroundColor = .systemBackground
        tableView.frame = view.bounds
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
    }

    func numberOfSections(in tableView: UITableView) -> Int { 3 }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return resourceNames.count
        case 1: return 4
        default: return 3
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "IMUIKit.bundle 图片"
        case 1: return "Toast"
        default: return "弹窗 / 导航 / 二维码"
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            ?? UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell.accessoryType = .disclosureIndicator
        cell.imageView?.image = nil
        cell.detailTextLabel?.text = nil
        switch indexPath.section {
        case 0:
            let name = resourceNames[indexPath.row]
            let image = Self.sdkImage(named: name)
            cell.textLabel?.text = name
            cell.detailTextLabel?.text = image == nil ? "未找到" : "已找到"
            cell.imageView?.image = image
            cell.accessoryType = .none
        case 1:
            cell.textLabel?.text = ["成功", "失败", "提示", "加载（点一下关闭）"][indexPath.row]
        default:
            cell.textLabel?.text = ["Alert", "ActionSheet", "带返回按钮的下一页"][indexPath.row]
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch (indexPath.section, indexPath.row) {
        case (1, 0): showSuccessToast("成功图标来自 IMUIKit.bundle")
        case (1, 1): showFailureToast("失败")
        case (1, 2): showInfoToast("提示")
        case (1, 3):
            showLoadingToast("加载中")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) { dismissToast() }
        case (2, 0):
            showAlert(in: view, title: "标题", message: "内容", confirm: "确定", cancel: "取消", completion: nil)
        case (2, 1):
            showSheet(in: view, title: "底部弹窗", message: nil, confirm: "确认", cancel: "取消", completion: nil)
        case (2, 2):
            let page = IMBaseViewController()
            page.title = "返回"
            navigationController?.pushViewController(page, animated: true)
        default:
            break
        }
    }

    /// 与库内 `currentBundle` 相同：先类所在 bundle，再主 bundle，查找名为 IMUIKit 的资源包。
    static func sdkImage(named name: String) -> UIImage? {
        var containers = [Bundle(for: ViewController.self)]
        if Bundle.main !== containers.last {
            containers.append(Bundle.main)
        }
        for container in containers {
            if let url = container.url(forResource: "IMUIKit", withExtension: "bundle"),
               let bundle = Bundle(url: url),
               let image = UIImage(named: name, in: bundle, compatibleWith: nil) {
                return image
            }
        }
        return nil
    }
}
