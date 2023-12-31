// ignore_for_file: use_build_context_synchronously

import 'package:diary/controllers/savedlist_db_ops_hive.dart';
import 'package:diary/models/savedlist_db_model.dart';
import 'package:diary/presentation/screens/main_screen/main_screen.dart';
import 'package:diary/presentation/theme/app_color.dart';
import 'package:diary/presentation/util/get_colors.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:sizer/sizer.dart';

class SavedScreenFunctions {
  void _showCreateListDialog(BuildContext context) {
    TextEditingController listNameController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? AppColor.light.color
              : AppColor.showMenuDark.color,
          title: const Center(child: Text('Create a Saved List')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: listNameController,
                cursorColor: const Color(0xFF835DF1),
                decoration: const InputDecoration(
                  labelStyle: TextStyle(color: Colors.grey),
                  labelText: 'List Name',
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFF835DF1),
                    ),
                  ),
                ),
                autofocus: true,
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () async {
                  String listName = listNameController.text;
                  if (listName.isNotEmpty) {
                    await SavedListCtrl().createSavedList(listName);
                    // Navigator.pop(context); // Close the dialog
                  } else {
                    // Show a snackbar or handle the case when the list name is empty
                  }
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xFF835DF1)),
                ),
                child: const Text(
                  'Create List',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  showCreateListDialog(BuildContext context) {
    _showCreateListDialog(context);
  }

  Future<dynamic> _displayBottomSheet(BuildContext context, String entryId) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) => Container(
        color: GetColors().getAlertBoxColor(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                width: 10.w,
                height: 2.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).brightness == Brightness.light
                      ? AppColor.dark.color
                      : Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  Text('Save diary to...', style: TextStyle(fontSize: 17.sp)),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      SavedScreenFunctions().showCreateListDialog(context);
                    },
                    child: const Icon(
                      Icons.add,
                    ),
                  )
                ],
              ),
            ),
            const Divider(
              thickness: 1.5,
            ),
            ValueListenableBuilder(
              valueListenable:
                  Hive.box<SavedList>('_savedListBoxName').listenable(),
              builder: (context, box, child) {
                List<SavedList> savedList = box.values.toList();
                if (savedList.isNotEmpty) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: savedList.length,
                    itemBuilder: (context, index) {
                      String listName = savedList[index].listName;
                      String listId = savedList[index].id;
                      // Check if the diary entry is in the current SavedList
                      bool isChecked = SavedListCtrl()
                          .isDiaryEntryInSavedList(listId, entryId);
                      return InkWell(
                        onTap: () {
                         

                          isChecked == false
                              ? SavedListCtrl()
                                  .addMapToDiaryEntryIds(listId, entryId)
                              : SavedListCtrl()
                                  .deleteDiaryEntry(listId, entryId);

                          // Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: isChecked,
                                  onChanged: (bool? newValue) {},
                                  activeColor:
                                      isChecked ? Colors.green : Colors.red,
                                ),
                                Text(
                                  listName,
                                  style: TextStyle(fontSize: 16.5.sp),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const SizedBox(
                    height: 100,
                    child: Center(
                      child: Text(
                        'Create a list',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  );
                }
              },
            ),
            const Divider(
              thickness: 1.5,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Row(
                  children: [
                    const Icon(Icons.check_rounded),
                    SizedBox(
                      width: 9.sp,
                    ),
                    Text(
                      'Done',
                      style: TextStyle(fontSize: 16.5.sp),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> displayBottomSheet(BuildContext context, String entryId) async {
    await _displayBottomSheet(context, entryId);
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, SavedList savedList) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Theme.of(context).brightness == Brightness.light
              ? AppColor.light.color
              : AppColor.showMenuDark.color,
          title: const Text(
            'Delete Confirmation',
            style: TextStyle(
              fontSize: 27,
            ),
          ),
          content: const Text(
            'Are you sure you want to delete this?',
            style: TextStyle(fontSize: 17),
          ),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
              onPressed: () {
                SavedListCtrl().deleteSavedList(savedList.id);

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MainScreen()),
                  ModalRoute.withName('/main'),
                );
              },
            ),
          ],
        );
      },
    );
  }

  showDeleteConfirmationDialog(BuildContext context, SavedList savedList) {
    _showDeleteConfirmationDialog(context, savedList);
  }
}
