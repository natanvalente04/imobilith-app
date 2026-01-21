import 'package:alugueis_app/components/dialog/dialog_title.dart';
import 'package:alugueis_app/models/locatario.dart';
import 'package:alugueis_app/store/locatario_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class CadLocatarioDialog extends StatefulWidget {
  final LocatarioStore store;
  final Locatario? locatario;
  const CadLocatarioDialog({super.key, required this.store, this.locatario});



  @override
  State<CadLocatarioDialog> createState() => _CadLocatarioDialogState();

}



class _CadLocatarioDialogState extends State<CadLocatarioDialog> {
    final nomeController = TextEditingController();
    final cpfController = TextEditingController();
    final idadeController = TextEditingController();
    final enderecoController = TextEditingController();
    final dependentesController = TextEditingController();
    int? selecionado;
    bool existe = false;
    final cpfMask = MaskTextInputFormatter(
        mask: '###.###.###-##',
        filter: { "#": RegExp(r'[0-9]') },
      );
    @override
    void initState() {
      super.initState();
      // nomeController.text = widget.locatario?.nomeLocatario ?? "";
      // cpfController.text = widget.locatario?.cpf ?? "";
      // idadeController.text = widget.locatario?.idade.toString() ?? "";
      // enderecoController.text = widget.locatario?.enderecoUltimoImovel ?? "";
      // dependentesController.text = widget.locatario?.qtdDependentes.toString() ?? "";
      // selecionado = widget.locatario?.temPet ?? null;
      // if(widget.locatario != null){
      //   existe = true;
      // }
    }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: DialogTitle(title: "Cadastrar Locatario"),
      content: SizedBox(
      //   width: 750,
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       TextField(
      //         controller: nomeController,
      //         decoration: InputDecoration(labelText: "Nome*"),
      //         keyboardType: TextInputType.text,
      //       ),
      //       const SizedBox(height: 16),
      //       Row(
      //         children: [
      //           Expanded(
      //             child: TextField(
      //               controller: cpfController,
      //               decoration: InputDecoration(labelText: "CPF*"),
      //               enabled: !existe,
      //               keyboardType: TextInputType.number,
      //               inputFormatters: [
      //                 cpfMask
      //               ],                  
      //             ),
      //           ),
      //           const SizedBox(width: 16),
      //           Expanded(
      //             child: TextField(
      //               controller: idadeController,
      //               decoration: InputDecoration(labelText: "Idade*"),
      //               keyboardType: TextInputType.number,
      //               inputFormatters: [
      //                 FilteringTextInputFormatter.digitsOnly
      //               ],
      //             )
      //           )
      //         ],
      //       ),
      //       const SizedBox(height: 16),
      //       TextField(
      //         controller: enderecoController,
      //         decoration: InputDecoration(labelText: "Ultimo Endereço*"),
      //       ),
      //       const SizedBox(height: 16),
      //       Row(
      //         children: [
      //           Expanded(
      //             child: TextField(
      //               controller: dependentesController,
      //               decoration: InputDecoration(labelText: "Quantidade de dependentes*"),
      //               keyboardType: TextInputType.number,
      //               inputFormatters: [
      //                 FilteringTextInputFormatter.digitsOnly
      //               ],
      //             ),
      //           ),
      //           const SizedBox(width: 16),
      //           Expanded(
      //             child: DropdownButtonFormField<int>(
      //               value: selecionado,
      //               decoration: const InputDecoration(
      //                 labelText: "Possui pet?",
      //                 border: OutlineInputBorder(),
      //               ),
      //               items: const [
      //                 DropdownMenuItem(value: 1, child: Text("Sim")),
      //                 DropdownMenuItem(value: 0, child: Text("Não"))
      //               ],
      //               onChanged: (value){
      //                 setState((){
      //                   selecionado = value;
      //                 });
      //               }
      //             ),
      //           )
      //         ],
      //       ),
      //     ],
      //   ),
      ),
      // actions: [
      //   TextButton(
      //     onPressed: () => Navigator.pop(context),
      //     child: const Text("Cancelar"),
      //   ),
      //   ElevatedButton(
      //     onPressed: () {
      //       Locatario novoLocatario = Locatario(
      //         nomeLocatario: nomeController.text,
      //         cpf: cpfController.text,
      //         idade: int.tryParse(idadeController.text) ?? 0,
      //         enderecoUltimoImovel: enderecoController.text,
      //         qtdDependentes: int.tryParse(dependentesController.text) ?? 0,
      //         temPet: selecionado ?? 0,
      //       );
      //       existe ? 
      //       widget.store.updateLocatario(novoLocatario)
      //       : widget.store.addLocatario(novoLocatario);
      //       Navigator.pop(context);
      //     },
      //     child: const Text("Salvar"),
      //   ),
      // ],
    );
  }
}