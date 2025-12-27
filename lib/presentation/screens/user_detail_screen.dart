import 'package:flutter/material.dart';
import '../../core/session/auth_manager.dart';
import '../../di/service_locator.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/get_user_use_case.dart';

class UserDetailScreen extends StatefulWidget {
  final int userId;

  const UserDetailScreen({super.key, required this.userId});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  User? _user;
  bool _isLoading = true;
  String? _error;

  late final GetUserUseCase _getUserUseCase;

  @override
  void initState() {
    super.initState();
    _getUserUseCase = ServiceLocator().getUserUseCase;
    _loadUser();
  }

  Future<void> _loadUser() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final user = await _getUserUseCase(widget.userId, AuthManager.token ?? '');
      setState(() {
        _user = user;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? _buildErrorWidget()
              : _buildContent(),
    );
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red.shade300),
          const SizedBox(height: 16),
          Text('Failed to load user', style: TextStyle(color: Colors.grey.shade700)),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _loadUser,
            icon: const Icon(Icons.refresh),
            label: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    final user = _user!;
    return CustomScrollView(
      slivers: [
        // App Bar with Image
        SliverAppBar(
          expandedHeight: 280,
          pinned: true,
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.indigo.shade700,
                    Colors.indigo.shade500,
                  ],
                ),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    Hero(
                      tag: 'avatar_${user.id}',
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(user.image),
                        backgroundColor: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      user.fullName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '@${user.username}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        user.role.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // Content
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Personal Info
                _buildSection(
                  'Personal Information',
                  Icons.person,
                  [
                    _buildInfoRow('Email', user.email, Icons.email_outlined),
                    _buildInfoRow('Phone', user.phone, Icons.phone_outlined),
                    _buildInfoRow('Birthday', user.birthDate, Icons.cake_outlined),
                    _buildInfoRow('Age', '${user.age} years', Icons.calendar_today_outlined),
                    _buildInfoRow('Gender', user.gender, Icons.wc_outlined),
                    _buildInfoRow('Blood Group', user.bloodGroup, Icons.bloodtype_outlined),
                  ],
                ),

                const SizedBox(height: 16),

                // Physical Info
                _buildSection(
                  'Physical Information',
                  Icons.accessibility_new,
                  [
                    _buildInfoRow('Height', '${user.height} cm', Icons.height),
                    _buildInfoRow('Weight', '${user.weight} kg', Icons.monitor_weight_outlined),
                    _buildInfoRow('Eye Color', user.eyeColor, Icons.remove_red_eye_outlined),
                    _buildInfoRow('Hair', '${user.hair.color} (${user.hair.type})', Icons.face_outlined),
                  ],
                ),

                const SizedBox(height: 16),

                // Address
                _buildSection(
                  'Address',
                  Icons.location_on,
                  [
                    _buildInfoRow('Street', user.address.address, Icons.home_outlined),
                    _buildInfoRow('City', user.address.city, Icons.location_city_outlined),
                    _buildInfoRow('State', '${user.address.state} (${user.address.stateCode})', Icons.map_outlined),
                    _buildInfoRow('Postal Code', user.address.postalCode, Icons.local_post_office_outlined),
                    _buildInfoRow('Country', user.address.country, Icons.public),
                  ],
                ),

                const SizedBox(height: 16),

                // Company
                _buildSection(
                  'Company',
                  Icons.business,
                  [
                    _buildInfoRow('Name', user.company.name, Icons.business_outlined),
                    _buildInfoRow('Department', user.company.department, Icons.category_outlined),
                    _buildInfoRow('Title', user.company.title, Icons.work_outline),
                  ],
                ),

                const SizedBox(height: 16),

                // Education
                _buildSection(
                  'Education',
                  Icons.school,
                  [
                    _buildInfoRow('University', user.university, Icons.school_outlined),
                  ],
                ),

                const SizedBox(height: 16),

                // Bank Info
                _buildSection(
                  'Bank Information',
                  Icons.account_balance,
                  [
                    _buildInfoRow('Card Type', user.bank.cardType, Icons.credit_card),
                    _buildInfoRow('Card Number', _maskCardNumber(user.bank.cardNumber), Icons.credit_card_outlined),
                    _buildInfoRow('Expires', user.bank.cardExpire, Icons.calendar_month_outlined),
                    _buildInfoRow('Currency', user.bank.currency, Icons.attach_money),
                  ],
                ),

                const SizedBox(height: 16),

                // Crypto
                _buildSection(
                  'Crypto',
                  Icons.currency_bitcoin,
                  [
                    _buildInfoRow('Coin', user.crypto.coin, Icons.monetization_on_outlined),
                    _buildInfoRow('Network', user.crypto.network, Icons.wifi_tethering),
                    _buildInfoRow('Wallet', _truncateWallet(user.crypto.wallet), Icons.wallet_outlined),
                  ],
                ),

                const SizedBox(height: 16),

                // Technical Info
                _buildSection(
                  'Technical Information',
                  Icons.computer,
                  [
                    _buildInfoRow('IP Address', user.ip, Icons.router_outlined),
                    _buildInfoRow('MAC Address', user.macAddress, Icons.settings_ethernet),
                  ],
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSection(String title, IconData icon, List<Widget> children) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: Colors.indigo, size: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: Colors.grey.shade500),
          const SizedBox(width: 12),
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _maskCardNumber(String cardNumber) {
    if (cardNumber.length < 4) return cardNumber;
    return '**** **** **** ${cardNumber.substring(cardNumber.length - 4)}';
  }

  String _truncateWallet(String wallet) {
    if (wallet.length <= 20) return wallet;
    return '${wallet.substring(0, 10)}...${wallet.substring(wallet.length - 10)}';
  }
}
