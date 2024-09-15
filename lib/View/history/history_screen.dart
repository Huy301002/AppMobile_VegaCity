import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/history/order_screen.dart';
import 'package:flutter_application_1/View/history/transaction_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Text('Hoạt động'),
          centerTitle: true,
          leading: Container(),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Đơn hàng'),
              Tab(text: 'Giao dịch'),
            ],
            labelColor: Color.fromARGB(255, 30, 144, 255),
            unselectedLabelColor: Colors.black,
            indicatorColor: Color.fromARGB(255, 30, 144, 255),
          ),
        ),
        body: const TabBarView(
          children: [
            OrderScreen(),
            TransactionScreen(),
          ],
        ),
      ),
    );
  }
}
