import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/certificates_data.dart';
import '../../../../core/entities/certificate.dart';
import '../../../../core/widgets/custom_widgets.dart';

class CertificatesSection extends StatefulWidget {
  const CertificatesSection({super.key});

  @override
  State<CertificatesSection> createState() => _CertificatesSectionState();
}

class _CertificatesSectionState extends State<CertificatesSection> {
  String selectedCategory = 'Todos';
  List<Certificate> filteredCertificates = CertificatesData.certificates;

  @override
  void initState() {
    super.initState();
    filteredCertificates = CertificatesData.certificates;
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width > 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : 24,
        vertical: 80,
      ),
      child: Column(
        children: [
          FadeInUp(
            duration: const Duration(milliseconds: 800),
            child: Text(
              'Certificações',
              style: Theme.of(
                context,
              ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16),
          FadeInUp(
            duration: const Duration(milliseconds: 1000),
            delay: const Duration(milliseconds: 200),
            child: Text(
              'Certificações e credenciais obtidas',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),

          // Certificates Overview
          FadeInUp(
            duration: const Duration(milliseconds: 1200),
            delay: const Duration(milliseconds: 400),
            child: _buildCertificatesOverview(context),
          ),
          const SizedBox(height: 40),

          // Category Filter
          FadeInUp(
            duration: const Duration(milliseconds: 1400),
            delay: const Duration(milliseconds: 600),
            child: _buildCategoryFilter(context),
          ),
          const SizedBox(height: 40),

          // Certificates Grid
          FadeInUp(
            duration: const Duration(milliseconds: 1600),
            delay: const Duration(milliseconds: 800),
            child: _buildCertificatesGrid(context, isDesktop),
          ),
        ],
      ),
    );
  }

  Widget _buildCertificatesOverview(BuildContext context) {
    final validCount = CertificatesData.validCertificates.length;
    final totalCount = CertificatesData.certificates.length;
    final expiredCount = CertificatesData.expiredCertificates.length;

    return CustomCard(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem(
            context,
            'Válidos',
            '$validCount',
            Icons.verified,
            Theme.of(context).colorScheme.secondary,
          ),
          _buildStatItem(
            context,
            'Total',
            '$totalCount',
            Icons.workspace_premium,
            Theme.of(context).primaryColor,
          ),
          if (expiredCount > 0)
            _buildStatItem(
              context,
              'Expirados',
              '$expiredCount',
              Icons.timer_off,
              Colors.orange,
            ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryFilter(BuildContext context) {
    final categories = ['Todos', ...CertificatesData.categories];

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category;

          return Container(
            margin: const EdgeInsets.only(right: 12),
            child: FilterChip(
              label: Text(category),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  selectedCategory = category;
                  _filterCertificates();
                });
              },
              selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
              checkmarkColor: Theme.of(context).primaryColor,
            ),
          );
        },
      ),
    );
  }

  Widget _buildCertificatesGrid(BuildContext context, bool isDesktop) {
    if (filteredCertificates.isEmpty) {
      return const EmptyStateWidget(
        title: 'Nenhum certificado encontrado',
        description: 'Tente selecionar uma categoria diferente',
        icon: Icons.workspace_premium_outlined,
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isDesktop ? 3 : 1,
        childAspectRatio: isDesktop ? 0.9 : 1.1,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
      ),
      itemCount: filteredCertificates.length,
      itemBuilder: (context, index) {
        final certificate = filteredCertificates[index];
        return _buildCertificateCard(context, certificate, index);
      },
    );
  }

  Widget _buildCertificateCard(
    BuildContext context,
    Certificate certificate,
    int index,
  ) {
    final isExpired =
        certificate.expirationDate != null &&
        certificate.expirationDate!.isBefore(DateTime.now());

    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      delay: Duration(milliseconds: 150 * index),
      child: CustomCard(
        onTap: certificate.credentialUrl != null
            ? () => _launchUrl(certificate.credentialUrl!)
            : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Certificate Image
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Theme.of(context).primaryColor.withOpacity(0.1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: certificate.imageUrl != null
                    ? Image.network(
                        certificate.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildPlaceholderImage(context);
                        },
                      )
                    : _buildPlaceholderImage(context),
              ),
            ),
            const SizedBox(height: 16),

            // Certificate Title
            Text(
              certificate.title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),

            // Issuer
            Row(
              children: [
                Icon(
                  Icons.business,
                  size: 16,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    certificate.issuer,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Description
            if (certificate.description != null) ...[
              Text(
                certificate.description!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.7),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
            ],

            const Spacer(),

            // Category and Status
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    certificate.category,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Spacer(),
                _buildStatusIndicator(context, isExpired),
              ],
            ),
            const SizedBox(height: 12),

            // Issue Date
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 14,
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.6),
                ),
                const SizedBox(width: 4),
                Text(
                  'Emitido em ${DateFormat('MM/yyyy').format(certificate.issueDate)}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),

            // Expiration Date
            if (certificate.expirationDate != null) ...[
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    Icons.schedule,
                    size: 14,
                    color: isExpired
                        ? Colors.red
                        : Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.6),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    isExpired
                        ? 'Expirou em ${DateFormat('MM/yyyy').format(certificate.expirationDate!)}'
                        : 'Expira em ${DateFormat('MM/yyyy').format(certificate.expirationDate!)}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: isExpired
                          ? Colors.red
                          : Theme.of(
                              context,
                            ).colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ],

            // View Credential Button
            if (certificate.credentialUrl != null) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => _launchUrl(certificate.credentialUrl!),
                  icon: const Icon(Icons.open_in_new, size: 16),
                  label: const Text('Ver Credencial'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor.withOpacity(0.1),
      child: Icon(
        Icons.workspace_premium,
        size: 48,
        color: Theme.of(context).primaryColor.withOpacity(0.5),
      ),
    );
  }

  Widget _buildStatusIndicator(BuildContext context, bool isExpired) {
    if (isExpired) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.timer_off, size: 12, color: Colors.red),
            const SizedBox(width: 4),
            Text(
              'Expirado',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.verified,
              size: 12,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(width: 4),
            Text(
              'Válido',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }
  }

  void _filterCertificates() {
    if (selectedCategory == 'Todos') {
      filteredCertificates = CertificatesData.certificates;
    } else {
      filteredCertificates = CertificatesData.getByCategory(selectedCategory);
    }
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
