import 'package:flutter/material.dart';

class BillingDashboard extends StatelessWidget {
  const BillingDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        title: const Text(
          'Billing Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Overview',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Here is your billing summary.',
              style: TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 20),

            // Summary cards
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.35,

              children: const [
                SummaryCard(
                  title: 'Total Revenue',
                  value: 'EGP 45,000',
                  icon: Icons.account_balance_wallet_outlined,
                  color: Colors.blue,
                ),
                SummaryCard(
                  title: 'Paid Invoices',
                  value: '32',
                  icon: Icons.check_circle_outline,
                  color: Colors.green,
                ),
                SummaryCard(
                  title: 'Pending',
                  value: '12',
                  icon: Icons.pending_actions,
                  color: Colors.orange,
                ),
                SummaryCard(
                  title: 'Overdue',
                  value: '4',
                  icon: Icons.warning_amber_rounded,
                  color: Colors.red,
                ),
              ],
            ),

            const SizedBox(height: 28),

            // Quick actions
            const Text(
              'Quick Actions',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 14),

            Row(
              children: [
                Expanded(
                  child: ActionButton(
                    title: 'New Invoice',
                    icon: Icons.add,
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ActionButton(
                    title: 'Customers',
                    icon: Icons.people_outline,
                    onTap: () {},
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            // Recent invoices
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Invoices',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                TextButton(
                  onPressed: () {},
                  child: const Text('View All'),
                ),
              ],
            ),

            const SizedBox(height: 8),

            const InvoiceTile(
              invoiceId: 'INV-1001',
              customer: 'Ahmed Hassan',
              amount: 'EGP 5,000',
              status: 'Paid',
              statusColor: Colors.green,
            ),

            const InvoiceTile(
              invoiceId: 'INV-1002',
              customer: 'Mohamed Ali',
              amount: 'EGP 2,500',
              status: 'Pending',
              statusColor: Colors.orange,
            ),

            const InvoiceTile(
              invoiceId: 'INV-1003',
              customer: 'Sara Mahmoud',
              amount: 'EGP 1,200',
              status: 'Overdue',
              statusColor: Colors.red,
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,

        onTap: (index) {
          // Navigate to the selected screen.
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: 'Invoices',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: 'Customers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            label: 'Reports',
          ),
        ],
      ),
    );
  }
}

// Summary card widget
class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const SummaryCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Icon(icon, color: color, size: 28),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Quick action button
class ActionButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const ActionButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon),
      label: Text(title),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}

// Invoice list item
class InvoiceTile extends StatelessWidget {
  final String invoiceId;
  final String customer;
  final String amount;
  final String status;
  final Color statusColor;

  const InvoiceTile({
    super.key,
    required this.invoiceId,
    required this.customer,
    required this.amount,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 10),

      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.withValues(alpha: 0.1),
          child: const Icon(
            Icons.receipt_long,
            color: Colors.blue,
          ),
        ),

        title: Text(
          invoiceId,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),

        subtitle: Text(customer),

        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,

          children: [
            Text(
              amount,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 4),

            Text(
              status,
              style: TextStyle(
                color: statusColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}