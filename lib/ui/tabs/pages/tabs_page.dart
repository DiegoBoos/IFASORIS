import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/usuario_entity.dart';
import '../../blocs/auth/auth_bloc.dart';
import '../../blocs/sync/sync_bloc.dart';
import '../../cubits/internet/internet_cubit.dart';
import '../../utils/styles.dart';
import '../widgets/sync_dialog.dart';
import '../widgets/custom_snack_bar.dart';
import 'home_page.dart';
import 'screen1_page.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  final List<Widget> _widgetOptions = [
    const HomePage(),
    const Screen1Page(),
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final usuario = authBloc.state.usuario!;
    final internetCubit = BlocProvider.of<InternetCubit>(context);

    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: size.width > 500
            ? PreferredSize(
                preferredSize: size,
                child: NavBar(
                    usuario: usuario,
                    internetCubit: internetCubit,
                    authBloc: authBloc),
              )
            : PreferredSize(
                preferredSize: Size.fromHeight(size.height * 0.08),
                child: MobileAppBar(
                    usuario: usuario,
                    internetCubit: internetCubit,
                    authBloc: authBloc)),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: size.width > 500
            ? Padding(
                padding: const EdgeInsets.all(30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, 'sign-in');
                        },
                        icon: const Icon(Icons.logout,
                            color: Styles.obscureGreen)),
                    /* IconButton(
                      icon: const Icon(Icons.cloud_upload,
                          color: Styles.obscureGreen),
                      onPressed: () {
                        if (internetCubit.state is InternetConnected) {
                          showDialog(
                              context: context,
                              builder: (_) => CustomGeneralDialog(
                                  title: '¿Desea Sincronizar?',
                                  subtitle: '',
                                  confirmText: 'Sincronizar',
                                  cancelText: 'Cancelar',
                                  onTapConfirm: () {
                                    Navigator.pop(context);
                                    BlocProvider.of<SyncBloc>(context)
                                        .add(SyncStarted(usuario, 'P'));
                                  },
                                  onTapCancel: () {
                                    Navigator.pop(context);
                                  }));
                        } else if (internetCubit.state
                            is InternetDisconnected) {
                          CustomSnackBar.showSnackBar(
                              context,
                              'No fue posible sincronizar, no hay conexión a internet',
                              Colors.red);
                          return;
                        }
                      },
                    ), */
                  ],
                ),
              )
            : BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
                items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: 'Inicio'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.screen_lock_landscape), label: ''),
                  ]));
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class NavBar extends StatefulWidget {
  const NavBar({
    Key? key,
    required this.usuario,
    required this.internetCubit,
    required this.authBloc,
  }) : super(key: key);

  final UsuarioEntity usuario;
  final InternetCubit internetCubit;
  final AuthBloc authBloc;

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 10,
        child: TabBarView(controller: tabController, children: [Container()]));
  }
}

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({Key? key, required this.controller, required this.tabs})
      : super(key: key);

  final TabController controller;
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: TabBar(
          labelColor: Styles.obscureGreen,
          indicatorColor: Styles.obscureGreen,
          controller: controller,
          tabs: tabs),
    );
  }
}

class CustomTab extends StatelessWidget {
  const CustomTab({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Tab(
      child: Text(
        title,
        style: const TextStyle(fontSize: 17),
      ),
    );
  }
}

class MobileAppBar extends StatelessWidget {
  const MobileAppBar({
    Key? key,
    required this.usuario,
    required this.internetCubit,
    required this.authBloc,
  }) : super(key: key);

  final UsuarioEntity usuario;
  final InternetCubit internetCubit;
  final AuthBloc authBloc;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          Navigator.pushReplacementNamed(context, 'sign-in');
        }
      },
      child: BlocBuilder<SyncBloc, SyncState>(
        builder: (context, state) {
          if (state is InitializingSync) {
            return AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Iniciando sincronización...',
                      style: TextStyle(color: Colors.white)),
                  SizedBox(width: 10),
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            );
          }
          if (state is SyncDownloading) {
            return AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      '${state.syncProgress.title} ${state.syncProgress.percent}%',
                      style: const TextStyle(color: Colors.white)),
                  const SizedBox(width: 10),
                  const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            );
          }
          if (state is SyncInProgress) {
            return AppBar(
              centerTitle: true,
              title: Text(
                  '${state.syncProgress.title} ${state.syncProgress.counter}',
                  style: const TextStyle(color: Colors.white)),
            );
          } else {
            return AppBar(
              leading: const Icon(Icons.person_pin),
              title: Text(usuario.userName,
                  style: const TextStyle(color: Colors.white)),
              actions: [
                IconButton(
                    onPressed: () => authBloc.add(LogOut()),
                    icon: const Icon(Icons.logout)),
                IconButton(
                  icon: const Icon(Icons.cloud_upload),
                  onPressed: () {
                    if (internetCubit.state is InternetConnected) {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return const SyncDialog();
                          });
                    } else if (internetCubit.state is InternetDisconnected) {
                      CustomSnackBar.showSnackBar(
                          context,
                          'No es posible sincronizar, revise su conexión a internet',
                          Colors.red);
                    }
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
