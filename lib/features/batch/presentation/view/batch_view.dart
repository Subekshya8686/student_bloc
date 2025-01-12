import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:softwarica_student_management_bloc/core/common/snackbar/my_snackbar.dart';
import 'package:softwarica_student_management_bloc/features/batch/presentation/view_model/batch_bloc.dart';

class BatchView extends StatelessWidget {
  BatchView({super.key});

  final batchNameController = TextEditingController();

  final _batchViewFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _batchViewFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: batchNameController,
                decoration: const InputDecoration(
                  labelText: 'Batch Name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter batch name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_batchViewFormKey.currentState!.validate()) {
                    context.read<BatchBloc>().add(
                          AddBatch(
                            batchNameController.text.trim(),
                          ),
                        );
                    // BlocProvider.of<BatchBloc>(context).add(
                    //   AddBatch(
                    //     BatchEntity(
                    //       batchName: batchNameController.text.trim(),
                    //     ),
                    //   ),
                    // );
                  }
                },
                child: BlocBuilder<BatchBloc, BatchState>(
                  builder: (context, state) {
                    return Text('Add Batch');
                  },
                ),
              ),
              SizedBox(height: 8),
              BlocBuilder<BatchBloc, BatchState>(builder: (context, state) {
                if (state.batches.isEmpty) {
                  return Text("No data found");
                } else if (state.isLoading) {
                  return CircularProgressIndicator();
                } else if (state.error != null) {
                  return showMySnackBar(
                    context: context,
                    message: state.error!,
                    color: Colors.red,
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.batches.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(state.batches[index].batchName),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              context.read<BatchBloc>().add(
                                    DeleteBatch(state.batches[index].batchId!),
                                  );
                              // BlocProvider.of<BatchBloc>(context).add(
                              //   DeleteBatch(state.batches[index].id),
                              // );
                            },
                          ),
                        );
                      },
                    ),
                  );
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
