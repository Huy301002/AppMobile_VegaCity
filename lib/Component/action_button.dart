import 'package:flutter/material.dart';

// import '../pages/transfer_money.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 35.0),
        child: Container(
          width: double.infinity,
          alignment: Alignment.center,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3), // Màu và độ mờ của bóng
                spreadRadius: 2, // Độ lan tỏa của bóng
                blurRadius: 3, // Độ mờ của bóng
                offset: Offset(0, 0.5), // Độ lệch của bóng (x,y)
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ActionButton(
                icon: Icons.account_balance,
                label: 'Deposit',
                onPressed: () {},
              ),
              ActionButton(
                icon: Icons.swap_horiz,
                label: 'Transfer',
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=> const TransferMoney()));
                },
              ),
              ActionButton(
                icon: Icons.attach_money,
                label: 'Withdraw',
                onPressed: () {},
              ),
              ActionButton(
                icon: Icons.apps_sharp,
                label: 'More',
                onPressed: () {},
              ),
            ],
          ),
        ));
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton(
      {super.key, required this.icon, required this.label, this.onPressed});

  final IconData icon;
  final String label;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton.outlined(
          onPressed: onPressed,
          icon: Icon(
            icon,
            color: const Color.fromARGB(255, 30, 144, 255),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
