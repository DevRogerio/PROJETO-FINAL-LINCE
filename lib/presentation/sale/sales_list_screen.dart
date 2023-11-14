import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:provider/provider.dart';
import 'package:share_extend/share_extend.dart';
import '../state/registerstore/register_store_state.dart';
import '../state/sale/sales_state.dart';
import '../utils/utils/app_bar.dart';
import '../utils/utils/menu.dart';
import 'edit_sale.dart';

/// Screen of Sale
class SearchSale extends StatelessWidget {
  /// class of Sale
  const SearchSale({super.key});

  @override
  Widget build(BuildContext context) {
    final mainState = Provider.of<RegistroState>(context);
    return ChangeNotifierProvider(
      create: (context) => RegistroStateSale(mainState.logUser, null),
      child: Consumer<RegistroStateSale>(
        builder: (_, state, __) {
          final numberFormatter = NumberFormat('###,###,###.00');
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: BarraSuperior(),
            drawer: const DrawerMenu(),
            body: Container(
              width: 5000,
              height: 5000,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
              ),
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 75),
                itemCount: state.listSale.length,
                itemBuilder: (context, index) {
                  final salesTable = state.listSale[index];
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 1, vertical: 25),
                    width: 75,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: ListTile(
                      leading: Text(salesTable.name.toString()),
                      title: Text(
                          'R\$${numberFormatter.format(salesTable.priceSold)}'),
                      subtitle: Text(salesTable.cpf.toString()),
                      trailing: IntrinsicWidth(
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () async {
                                await state.delete(salesTable);
                              },
                              icon: const Icon(
                                Icons.delete,
                                size: 25,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                state.editSearch(salesTable);
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ChangeNotifierProvider.value(
                                      value: state,
                                      child: const EditSaleSearch(),
                                    ),
                                  ),
                                );
                              },
                              icon: const Icon(
                                // ignore: deprecated_member_use
                                FontAwesomeIcons.chevronCircleRight,
                                color: Colors.white,
                                size: 35,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                              width: 10,
                            ),
                            ElevatedButton.icon(
                                onPressed: () {
                                  _gerarPDF(
                                      salesTable.businessCut.toString(),
                                      salesTable.dealershipCut.toString(),
                                      salesTable.cpf.toString(),
                                      salesTable.name.toString(),
                                      salesTable.soldWhen.toString(),
                                      salesTable.priceSold.toString());
                                },
                                icon: const Icon(
                                    size: 2, Icons.picture_as_pdf_outlined),
                                label: const Text('PDF'))
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

void _gerarPDF(String nome, String cpf, String data, String carro, String placa,
    String preco) async {
  final pdf = pw.Document(deflate: zlib.encode);

  pdf.addPage(
    pw.Page(
      build: (context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Nome: $nome',
                style:
                    pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
            pw.Text('CPF: $cpf',
                style:
                    pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
            pw.Text('Data: $data',
                style:
                    pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
            pw.Text('Carro: $carro',
                style:
                    pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
            pw.Text('Placa: $placa',
                style:
                    pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
            pw.Text('Preço: $preco',
                style:
                    pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
          ],
        );
      },
    ),
  );

  final docDir = (await getApplicationDocumentsDirectory()).path;

  final path = '$docDir/seu_arquivo.pdf';

  final file = File(path);
  file.writeAsBytesSync(await pdf.save());

  await ShareExtend.share(path, 'pdf', sharePanelTitle: 'enviar pdf');
}
