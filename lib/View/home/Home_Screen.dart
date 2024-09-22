import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Component/action_button.dart';
import 'package:flutter_application_1/entry_point.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/Logo.png'),
                      radius: 30,
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome Back!",
                            style: TextStyle(color: Colors.black),
                          ),
                          Text(
                            "Huy",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    IconButton.outlined(
                      onPressed: () {},
                      icon: const Icon(Icons.notifications),
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              // Carousel Slider
              Center(
                child: Column(
                  children: [
                    CarouselSlider(
                      items: imgList
                          .map((e) => ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  e,
                                  fit: BoxFit.cover,
                                  width: 1500,
                                ),
                              ))
                          .toList(),
                      options: CarouselOptions(
                        initialPage: 0,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        enlargeCenterPage: true,
                        enlargeFactor: 0.3,
                        onPageChanged: (value, _) {
                          setState(() {
                            _currentPage = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    buildCarouselIndicator(),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: const Column(
                      children: [
                        ActionButtons(),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
              // Tiêu đề Packages
              Container(
                margin: const EdgeInsets.only(left: 35, right: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Packages new",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EntryPoint(selectedIndex: 1)),
                        );
                      },
                      child: const Text(
                        "See All",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              // GridView cho card
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 18, right: 18),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Số cột
                    crossAxisSpacing: 8, // Khoảng cách giữa các cột
                    mainAxisSpacing: 10, // Khoảng cách giữa các hàng
                    childAspectRatio: 1, // Tỷ lệ khung hình
                  ),
                  itemCount: 4, // Số lượng card
                  itemBuilder: (context, index) {
                    return buildCard(
                      index == 0
                          ? "Combo trọn gói"
                          : index == 1
                              ? "Combo vui chơi khô"
                              : "Combo vui chơi nước",
                      imgList[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(String title, String imageUrl) {
    return Container(
      width: 160,
      height: 160,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
            ),
            child: Image.network(
              imageUrl,
              width: double.infinity,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  buildCarouselIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < imgList.length; i++)
          Container(
            width: i == _currentPage ? 7 : 5,
            height: i == _currentPage ? 7 : 5,
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: i == _currentPage
                  ? const Color.fromARGB(255, 30, 144, 255)
                  : Colors.grey,
            ),
          ),
      ],
    );
  }
}
