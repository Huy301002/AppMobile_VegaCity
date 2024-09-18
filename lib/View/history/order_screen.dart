import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final List<Map<String, dynamic>> transactions = [
    {
      'name': 'Nguyễn Văn A',
      'date': '12/09/2024',
      'time': '14:45',
      'package': 'Combo nước',
      'amount': '1200000VND',
      'status': 'Hoàn thành',
    },
    {
      'name': 'Trần Thị B',
      'date': '11/09/2024',
      'time': '10:30',
      'package': 'Combo trọn gói ',
      'amount': '1500000VND',
      'status': 'Chưa hoàn thành',
    },
    {
      'name': 'Lê Văn C',
      'date': '10/09/2024',
      'time': '09:20',
      'package': 'Combo Khô',
      'amount': '1000000VND',
      'status': 'Hoàn thành',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hàng trên cùng: Thời gian (trái) và trạng thái (phải)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${transaction['time']} ${transaction['date']}',
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      transaction['status'],
                      style: TextStyle(
                        color: transaction['status'] == 'Hoàn thành'
                            ? Colors.green
                            : Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Tên người giao dịch
                Text(
                  transaction['name'],
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                // Số tiền giao dịch
                Text(
                  'Gói: ${transaction['package']}',
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                // Số tiền giao dịch
                Text(
                  'Số tiền: ${transaction['amount']}',
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
