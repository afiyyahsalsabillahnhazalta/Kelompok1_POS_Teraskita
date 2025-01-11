import 'package:flutter/material.dart';

import 'NewOrderModal.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left Sidebar
          Container(
            width: 250,
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                // Logo
                Container(
                  padding: EdgeInsets.all(16),
                  child: Image.asset('assets/images/teras.png', height: 100),
                ),
                SizedBox(height: 10),
                // Menu Items
                _buildMenuItem(Icons.dashboard, 'Dashboard', true),
                _buildMenuItem(Icons.restaurant_menu, 'Menu', false),
                _buildMenuItem(Icons.receipt_long, 'Orders', false),
                _buildMenuItem(Icons.table_bar, 'Table', false),
                _buildMenuItem(Icons.summarize, 'Report', false),
                Spacer(),
                // User Profile
                ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    child: Icon(Icons.person, color: Colors.grey[600]),
                  ),
                  title: Text('Waiters',
                      style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                  subtitle: Text('Afiyyah Salsabillah',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500)),
                ),
                _buildMenuItem(Icons.logout, 'Logout', false),
              ],
            ),
          ),
          // Main Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Modified Stats Row
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left section (Orders + Payment)
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              // Stats Row
                              Row(
                                children: [
                                  Expanded(
                                      child: _buildStatCard(
                                          'New Orders', '10', Colors.purple)),
                                  SizedBox(width: 16),
                                  Expanded(
                                      child: _buildStatCard('Total Orders',
                                          '40', Colors.grey[300]!)),
                                  SizedBox(width: 16),
                                  Expanded(
                                      child: _buildStatCard(
                                          'Waiting List', '5', Colors.white)),
                                ],
                              ),
                              SizedBox(height: 16),
                              // Order List and Payment Section
                              Expanded(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(child: _buildOrderList()),
                                    SizedBox(width: 16),
                                    Expanded(child: _buildPaymentSection()),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16),
                        // Right Panel
                        Container(
                          width: 300,
                          child: Column(
                            children: [
                              // Create New Order Button
                              Container(
                                width: double.infinity,
                                height: 85, // Match height with stat cards
                                child: Card(
                                  color: Colors.blue,
                                  child: InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => NewOrderModal(),
                                      );
                                    },
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.add, color: Colors.white),
                                          SizedBox(width: 8),
                                          Text(
                                            'CREATE NEW ORDER',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16),
                              Expanded(child: _buildPopularDishes()),
                              SizedBox(height: 16),
                              Expanded(child: _buildOutOfStock()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, bool isSelected) {
    return ListTile(
      leading: Icon(icon, color: isSelected ? Colors.blue : Colors.grey[600]),
      title: Text(title,
          style: TextStyle(
              color: isSelected ? Colors.blue : Colors.black,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal)),
      selected: isSelected,
      onTap: () {},
    );
  }

  Widget _buildStatCard(String title, String value, Color color) {
    return Container(
      width: 200,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: color == Colors.purple ? Colors.white : Colors.black)),
          Text(title,
              style: TextStyle(
                  color: color == Colors.purple
                      ? Colors.white.withOpacity(0.8)
                      : Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildOrderList() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text('Order List',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search a Order',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 8,
              padding: EdgeInsets.all(16),
              itemBuilder: (context, index) {
                return _buildOrderItem(
                    'A${index + 1}', 'Customer ${index + 1}');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem(String orderNo, String customerName) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(orderNo,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(customerName,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                Text('4 items',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.orange[100],
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text('In Progress',
                style: TextStyle(color: Colors.orange[800], fontSize: 12)),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentSection() {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text('Payment',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search a Order',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 2,
              padding: EdgeInsets.all(16),
              itemBuilder: (context, index) {
                return _buildPaymentItem(
                    'A${index + 1}', 'Customer ${index + 1}');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentItem(String orderNo, String customerName) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(orderNo,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(customerName,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                Text('\$24.00',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('Pay Now'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPopularDishes() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Popular Dishes',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {},
                  child: Text('View All'),
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: Text('${index + 1}'),
                  ),
                  title: Text('Dish ${index + 1}'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOutOfStock() {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Out of Stock',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {},
                  child: Text('View All'),
                ),
              ],
            ),
            ListTile(
              title: Text(''),
              subtitle: Text('', style: TextStyle(color: Colors.blue)),
            ),
          ],
        ),
      ),
    );
  }
}
