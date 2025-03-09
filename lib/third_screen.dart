import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_developer_intern/bloc/app_bloc.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  final controller = ScrollController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      if (controller.position.maxScrollExtent == controller.offset) {
        context.read<AppBloc>().add(OnLoadLazy());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Third Screen',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(2),
          child: Container(color: Color(0xffE2E3E4), height: 1),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Image.asset('assets/images/back.png', width: 24),
        ),
      ),
      body: BlocConsumer<AppBloc, AppState>(
        listener: (context, state) {
          if (state is AppLoggedUser) {
            if (state.selectedName.isNotEmpty && state.clicked) {
              state.clicked = !state.clicked;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 1),
                  content: Text('${state.selectedName} is selected!'),
                ),
              );
            }
          }
        },
        builder: (context, state) {
          if (state is AppLoading) {
            return Center(child: CircularProgressIndicator.adaptive());
          } else if (state is AppLoggedUser) {
            if (state.dataUser.isEmpty) {
              return Center(child: Text('The data is empty.'));
            }
            return RefreshIndicator(
              onRefresh: () async {
                context.read<AppBloc>().add(OnRefresh());
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
                child: ListView.builder(
                  controller: controller,
                  itemCount: state.dataUser.length + 1,
                  itemBuilder: (context, index) {
                    if (index < state.dataUser.length) {
                      final user = state.dataUser[index];
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              context.read<AppBloc>().add(
                                OnClickUserList(
                                  selectedUser:
                                      '${user.first_name} ${user.last_name}',
                                ),
                              );
                            },
                            child: ListTile(
                              title: Text(
                                '${user.first_name} ${user.last_name}',
                                style: TextStyle(
                                  color: Color(0xff04021D),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(
                                user.email,
                                style: TextStyle(
                                  color: Color(0xff686777),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(user.avatar),
                              ),
                            ),
                          ),
                          Divider(color: Color(0xffE2E3E4)),
                        ],
                      );
                    } else if (state.isLoadingMore) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 32),
                        child: Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      );
                    }
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 32),
                      child: Center(child: Text('Sudah mencapai batas!')),
                    );
                  },
                ),
              ),
            );
          } else if (state is AppFailed) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text("Error"));
          }
        },
      ),
    );
  }
}
