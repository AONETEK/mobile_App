import 'package:flutter/material.dart';
import 'package:loginkeycloakapp/main.dart';
import 'package:loginkeycloakapp/src/screen/asset/allocationAssetScreen.dart';
import 'package:loginkeycloakapp/src/screen/asset/fixedAssetsScreen.dart';
import 'package:loginkeycloakapp/src/screen/asset_depreciation/depreciationOfAllocatedAssetsScreen.dart';
import 'package:loginkeycloakapp/src/screen/asset_depreciation/depreciationOfFixedAssetsScreen.dart';
import 'package:loginkeycloakapp/src/screen/bank/InternalTransferScreen.dart';
import 'package:loginkeycloakapp/src/screen/bank/cashCollectionScreen.dart';
import 'package:loginkeycloakapp/src/screen/bank/cashPaymentScreen.dart';
import 'package:loginkeycloakapp/src/screen/bank/collectDepositScreen.dart';
import 'package:loginkeycloakapp/src/screen/bank/depositPaymentScreen.dart';
import 'package:loginkeycloakapp/src/screen/contacts/customerScreen.dart';
import 'package:loginkeycloakapp/src/screen/contacts/supplierScreen.dart';
import 'package:loginkeycloakapp/src/screen/inventoryScreen.dart';
import 'package:loginkeycloakapp/src/screen/purchase/purchaseScreen.dart';
import 'package:loginkeycloakapp/src/screen/service/purchasedServicesScreen.dart';
import 'package:loginkeycloakapp/src/screen/service/salesServiceScreen.dart';
import 'package:loginkeycloakapp/src/screen/tax/corporateIncomesTaxScreen.dart';
import 'package:loginkeycloakapp/src/screen/tax/personalIncomeTaxScreen.dart';
import 'package:loginkeycloakapp/src/screen/tax/vat/prepareDeclarationScreen.dart';
import 'package:loginkeycloakapp/src/screen/tax/vat/purchaseLedgerScreen.dart';
import 'package:loginkeycloakapp/src/screen/tax/vat/sellLedgerScreen.dart';
// import 'package:loginkeycloakapp/src/screen/uploadScreen.dart';
import 'package:loginkeycloakapp/src/screen/warehouse/exportScreen.dart';
import 'package:loginkeycloakapp/src/screen/warehouse/importScreen.dart';
import '../screen/purchase/sellScreen.dart';
// import 'package:loginkeycloakapp/src/services/notification/notification.dart';

// final Notification_Api notification_api = Notification_Api();

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

//   @override
//   State<SideMenu> createState() => _SideMenuState();
// }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text("Ho Duc Lam"),
            accountEmail: const Text("hoduclam2408@gmail.com"),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.asset('assets/logo_bot.png'),
              ),
            ),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 54, 206, 135),
              // image: DecorationImage(image: AssetImage(assetName))
            ),
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text('Màn hình chính'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomeScreen()));
            },
          ),
          ExpansionTile(
            title: Text("Danh bạ"),
            leading: Icon(Icons.contacts_sharp),
            childrenPadding: EdgeInsets.only(left: 20),
            children: [
              ListTile(
                leading: Icon(Icons.people),
                title: Text("Khách hàng"),
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => CustomerScreen()))
                },
              ),
              ListTile(
                leading: Icon(Icons.business),
                title: Text("Nhà cung cấp"),
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SupplierScreen()))
                },
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.inventory),
            title: Text('Hàng tồn kho'),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => InventoryScreen()))
            },
          ),

          ExpansionTile(
            title: Text("Dịch vụ"),
            leading: Icon(Icons.miscellaneous_services),
            childrenPadding: EdgeInsets.only(left: 20),
            children: [
              ListTile(
                leading: Icon(Icons.people),
                title: Text("Dịch vụ mua vào"),
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PurchasedServicesScreen()))
                },
              ),
              ListTile(
                leading: Icon(Icons.business),
                title: Text("Dịch vụ bán ra"),
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SalesServiceScreen()))
                },
              ),
            ],
          ),
          ExpansionTile(
            title: Text("Tài sản"),
            leading: Icon(Icons.attach_money),
            childrenPadding: EdgeInsets.only(left: 20),
            children: [
              ListTile(
                leading: Icon(Icons.people),
                title: Text("Tài sản cố định"),
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FixedAssetsScreen()))
                },
              ),
              ListTile(
                leading: Icon(Icons.business),
                title: Text("Tài sản phân bổ"),
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AllocationAssetScreen()))
                },
              ),
            ],
          ),

          ExpansionTile(
            title: Text("Tiền và ngân hàng"),
            leading: Icon(Icons.account_balance),
            childrenPadding: EdgeInsets.only(left: 20),
            children: [
              ExpansionTile(
                title: Text("Tiền mặt"),
                leading: Icon(Icons.attach_money),
                childrenPadding: EdgeInsets.only(left: 20),
                children: [
                  ListTile(
                    leading: Icon(Icons.people),
                    title: Text("Thu tiền mặt"),
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CashCollectionScreen()))
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.business),
                    title: Text("Chi tiền mặt"),
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CashPaymentScreen()))
                    },
                  ),
                ],
              ),
              ExpansionTile(
                title: Text("Ngân hàng"),
                leading: Icon(Icons.account_balance),
                childrenPadding: EdgeInsets.only(left: 20),
                children: [
                  ListTile(
                    leading: Icon(Icons.business),
                    title: Text("Thu tiền gửi"),
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CollectDepositScreen()))
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.business),
                    title: Text("Chi tiền gửi"),
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DepositPaymentScreen()))
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.business),
                    title: Text("Chuyển tiền nội bộ"),
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => InternalTransferScreen()))
                    },
                  ),
                ],
              ),
            ],
          ),
          ListTile(
            leading: Icon(Icons.storefront),
            title: Text("Bán hàng"),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SellScreen()))
            },
          ),
          ListTile(
            leading: Icon(Icons.add_shopping_cart),
            title: Text("Mua hàng"),
            onTap: () => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PurchaseScreen()))
            },
          ),

          ExpansionTile(
            title: Text("Nhập xuất kho"),
            leading: Icon(Icons.local_shipping),
            childrenPadding: EdgeInsets.only(left: 20),
            children: [
              ListTile(
                leading: Icon(Icons.people),
                title: Text("Xuất kho"),
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ExportScreen()))
                },
              ),
              ListTile(
                leading: Icon(Icons.business),
                title: Text("Nhập kho"),
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ImportScreen()))
                },
              ),
            ],
          ),

          ExpansionTile(
            title: Text("Khấu hao Tài sản"),
            leading: Icon(Icons.trending_down),
            childrenPadding: EdgeInsets.only(left: 20),
            children: [
              ListTile(
                leading: Icon(Icons.people),
                title: Text("Khấu hao tài sản cố định"),
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DepreciationOfFixedassetsScreen()))
                },
              ),
              ListTile(
                leading: Icon(Icons.business),
                title: Text("Khấu hao tài sản phân bổ"),
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DepreciationOfAllocatedassetsScreen()))
                },
              ),
            ],
          ),

          ExpansionTile(
            title: Text("Thuế"),
            leading: Icon(Icons.local_atm),
            childrenPadding: EdgeInsets.only(left: 20),
            children: [
              ExpansionTile(
                title: Text("Thuế GTGT"),
                childrenPadding: EdgeInsets.only(left: 20),
                children: [
                  ListTile(
                    leading: Icon(Icons.business),
                    title: Text("Lập tờ khai"),
                    onTap: () => {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrepareDeclarationScreen()))
                    },
                  ),
                  ExpansionTile(
                    title: Text("Bảng kê hóa đơn"),
                    leading: Icon(Icons.business),
                    childrenPadding: EdgeInsets.only(left: 20),
                    children: [
                      ListTile(
                        leading: Icon(Icons.business),
                        title: Text("Bảng kê mua vào"),
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PurchaseledgerScreen()))
                        },
                      ),
                      ListTile(
                        leading: Icon(Icons.business),
                        title: Text("Bảng kê bán ra"),
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SellledgerScreen()))
                        },
                      ),
                    ],
                  )
                ],
              ),
              ListTile(
                leading: Icon(Icons.business),
                title: Text("Thuế TNDN"),
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CorporateIncomesTaxScreen()))
                },
              ),
              ListTile(
                leading: Icon(Icons.business),
                title: Text("Thuế TNCN"),
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PersonalIncomeTaxsSreen()))
                },
              ),
            ],
          ),
          // ListTile(
          //   leading: Icon(
          //     Icons.logout,
          //     color: Colors.red,
          //   ),
          //   title: Text("Logout"),
          //   textColor: Colors.red,
          //   onTap: () => {print("Đã upload")},
          // )
        ],
      ),
    );
  }
}
