import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kantin/providers/category_provider.dart';
import 'package:kantin/providers/product_provider.dart';
import 'package:kantin/theme.dart';
import 'package:provider/provider.dart';

class AddProdukPage extends StatefulWidget {
  @override
  State<AddProdukPage> createState() => _AddProdukPageState();
}

class _AddProdukPageState extends State<AddProdukPage> {
  TextEditingController nameController = TextEditingController();

  TextEditingController priceController = TextEditingController();

  File _image;

  String selectedCategory;

  String selectedTags;

  final ImagePicker _picker = ImagePicker();

  getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
      maxHeight: 1080,
      maxWidth: 1080,
    );
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        _image = null;
      }
    });
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Recommended"), value: "Recommended"),
      DropdownMenuItem(child: Text("Popular"), value: "Popular"),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
    CategoryProvider categoryProvider = Provider.of<CategoryProvider>(context);

    Future submitHandle() async {
      if (await productProvider.addProducts(
        nameController.text,
        priceController.text,
        selectedTags,
        selectedCategory,
        _image.path,
      )) {
        nameController.clear();
        priceController.clear();
        selectedCategory = null;
        selectedTags = null;
        _image = null;
        print('berhasil add produk');
      }
    }

    Widget header() {
      return AppBar(
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: blackColor,
            size: 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Add Produk',
          style: TextStyle(
            color: blackColor,
            fontSize: 18,
            fontWeight: bold,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.check,
              color: blackColor,
              size: 24,
            ),
            onPressed: () {
              setState(() {
                submitHandle();
              });
              // Navigator.pop(context);
            },
          ),
        ],
      );
    }

    Widget namaProdukInput() {
      return Container(
        margin: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Produk',
              style: blackTextStyle.copyWith(
                fontSize: 14,
                color: greyColor,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Nama Produk',
                hintStyle: subtitleTextStyle.copyWith(
                  color: greyColor,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: lightGrayColor,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: lightBlueColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget hargaInput() {
      return Container(
        margin: EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Harga',
              style: blackTextStyle.copyWith(
                fontSize: 14,
                color: greyColor,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: priceController,
              decoration: InputDecoration(
                hintText: 'Harga',
                hintStyle: subtitleTextStyle.copyWith(
                  color: greyColor,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: lightGrayColor,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: lightBlueColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget deskripsiInput() {
      return Container(
        margin: EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Deskripsi',
              style: blackTextStyle.copyWith(
                fontSize: 14,
                color: greyColor,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: 'Deskripsi',
                hintStyle: subtitleTextStyle.copyWith(
                  color: greyColor,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: lightGrayColor,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: lightBlueColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget tagsInput() {
      return Container(
        margin: EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tags',
              style: blackTextStyle.copyWith(
                fontSize: 14,
                color: greyColor,
              ),
            ),
            SizedBox(height: 10),
            DropdownButton(
                isExpanded: true,
                underline: Container(
                  color: lightGrayColor,
                  height: 2,
                ),
                hint: Text(
                  'Pilih Tags',
                  style: subtitleTextStyle.copyWith(),
                ),
                value: selectedTags,
                onChanged: (String newValue) {
                  setState(() {
                    selectedTags = newValue;
                  });
                },
                items: dropdownItems),
            // TextField(
            //   controller: tagsController,
            //   decoration: InputDecoration(
            //     hintText: 'Tags',
            //     hintStyle: subtitleTextStyle.copyWith(
            //       color: greyColor,
            //     ),
            //     enabledBorder: UnderlineInputBorder(
            //       borderSide: BorderSide(
            //         color: lightGrayColor,
            //       ),
            //     ),
            //     focusedBorder: UnderlineInputBorder(
            //       borderSide: BorderSide(
            //         color: lightBlueColor,
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      );
    }

    Widget dropdownCategory() {
      return Container(
        margin: EdgeInsets.only(top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kategori',
              style: blackTextStyle.copyWith(
                fontSize: 14,
                color: greyColor,
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 50,
              child: DropdownButton(
                isExpanded: true,
                underline: Container(
                  color: lightGrayColor,
                  height: 2,
                ),
                hint: Text(
                  'Pilih Kategori',
                  style: subtitleTextStyle.copyWith(),
                ),
                value: selectedCategory,
                onChanged: (value) {
                  setState(() {
                    selectedCategory = value;
                  });
                },
                items: categoryProvider.category.map((category) {
                  return DropdownMenuItem(
                    value: category.id.toString(),
                    child: Text(
                      category.name,
                      style: blackTextStyle.copyWith(),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      );
    }

    showPilihPhotoProduct() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Wrap(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    vertical: defaultMargin,
                    horizontal: defaultMargin,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      Center(
                        child: Text(
                          'Pilih Product Photo',
                          style: blackTextStyle.copyWith(
                            fontSize: 18,
                            fontWeight: bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              getImage(ImageSource.camera);
                            },
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: blueColor,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.add_a_photo,
                                color: blueColor,
                                size: 50,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              getImage(ImageSource.gallery);
                            },
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: blueColor,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Icon(
                                Icons.photo_library,
                                color: blueColor,
                                size: 50,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      )
                    ],
                  ),
                )
              ],
            );
          });
    }

    Widget content() {
      return ListView(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    // getImagefromGallery();
                    showPilihPhotoProduct();
                  },
                  child: _image == null
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: 206,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                'assets/image_add_produk.png',
                              ),
                            ),
                          ),
                        )
                      : Image.file(_image),
                ),
                namaProdukInput(),
                hargaInput(),
                // deskripsiInput(),
                tagsInput(),
                dropdownCategory(),
              ],
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: header(),
      ),
      body: content(),
      resizeToAvoidBottomInset: true,
    );
  }
}
