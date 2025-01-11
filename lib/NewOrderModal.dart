import 'package:flutter/material.dart';

class NewOrderModal extends StatefulWidget {
  @override
  _NewOrderModalState createState() => _NewOrderModalState();
}

class _NewOrderModalState extends State<NewOrderModal> {
  String _selectedTable = 'A2';
  int _selectedGuest = 4;
  String _orderType = 'dine_in';
  final _formKey = GlobalKey<FormState>();
  final _customerNameController = TextEditingController();

  @override
  void dispose() {
    _customerNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 8,
        child: Container(
          constraints: BoxConstraints(maxWidth: 400),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Create New Order',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => Navigator.pop(context),
                          splashRadius: 24,
                        ),
                      ],
                    ),
                    Divider(height: 32),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Expanded(
                            child: _OrderTypeButton(
                              icon: Icons.restaurant,
                              title: 'Dine In',
                              isSelected: _orderType == 'dine_in',
                              onTap: () =>
                                  setState(() => _orderType = 'dine_in'),
                            ),
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: _OrderTypeButton(
                              icon: Icons.takeout_dining,
                              title: 'Takeaway',
                              isSelected: _orderType == 'takeaway',
                              onTap: () =>
                                  setState(() => _orderType = 'takeaway'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24),
                    TextFormField(
                      controller: _customerNameController,
                      decoration: InputDecoration(
                        labelText: 'Customer Name',
                        hintText: 'Enter customer name',
                        prefixIcon: Icon(Icons.person_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                      ),
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return 'Please enter customer name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 24),
                    _CustomDropdown(
                      icon: Icons.group_outlined,
                      label: 'Number of Guests',
                      child: DropdownButton<int>(
                        value: _selectedGuest,
                        isExpanded: true,
                        underline: SizedBox(),
                        onChanged: (value) {
                          setState(() => _selectedGuest = value!);
                        },
                        items: List.generate(10, (index) => index + 1)
                            .map(
                              (i) => DropdownMenuItem(
                                value: i,
                                child: Text('$i Person${i > 1 ? 's' : ''}'),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    if (_orderType == 'dine_in') ...[
                      SizedBox(height: 24),
                      _CustomDropdown(
                        icon: Icons.table_restaurant,
                        label: 'Table Number',
                        child: DropdownButton<String>(
                          value: _selectedTable,
                          isExpanded: true,
                          underline: SizedBox(),
                          onChanged: (value) {
                            setState(() => _selectedTable = value!);
                          },
                          items: ['A1', 'A2', 'A3', 'B1', 'B2', 'B3']
                              .map(
                                (table) => DropdownMenuItem(
                                  value: table,
                                  child: Text('Table $table'),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                    SizedBox(height: 32),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          // Implement order creation logic
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Create Order',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors
                              .white, // Ganti 'Colors.blue' dengan warna yang diinginkan
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _OrderTypeButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _OrderTypeButton({
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: isSelected ? Theme.of(context).primaryColor : Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.white : Colors.grey.shade700,
                size: 28,
              ),
              SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomDropdown extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget child;

  const _CustomDropdown({
    required this.icon,
    required this.label,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade50,
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey.shade600),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
                child,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
