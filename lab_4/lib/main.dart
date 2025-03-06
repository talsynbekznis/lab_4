import 'package:flutter/material.dart';//основной пакет Флатерды импорттаймыз UI мен жұмыс істеу үшін
import 'package:fluttertoast/fluttertoast.dart'; // Подключаем пакет для Toast Notification,козгалту үшін қосамыз 

void main() {  //главная функция и начинаем 
  runApp(MyApp()); // Запускаем приложение и отоб виджет MyApp
}
class MyApp extends StatelessWidget { //наследуем 
  @override
  Widget build(BuildContext context) { //настроим 
    return MaterialApp( // возвращаем   MaterialApp
      debugShowCheckedModeBanner: false, // Отключаем баннер Debug в отладки
      theme: ThemeData(primarySwatch: Colors.blue), // устанавливаем синий цвет темы
      home: MainScreen(), // басты бетте MainScreen тұратынын көрсетіп тұр 
    );
  }
}                           //1 тапсырма 
 class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController( //вкладка создаем и внутри будет 2 
      length: 2, // Количество вкладок
      child: Scaffold( //каркас экрана 
        appBar: AppBar( //жоғарғы панель 
          title: Text('Flutter UI Components'),
          bottom: TabBar( //вкладки список и сетка 
            tabs: [
              Tab(icon: Icon(Icons.list), text: "ListView"),
              Tab(icon: Icon(Icons.grid_on), text: "GridView"),
       ],
     ),
  ), //5 тапсырма косамыз
    drawer: AppDrawer(),//боковой меню Drawer косылады 
      body: Stack( //элементтерді үсті үстіне қояды 
       children: [ TabBarView( // бұл 2 вкладканы жалғайды керек экранга
              children: [
                ItemListView(), // 2 тапсырма ListView
                ItemGridView(), // 3 тапсырма  GridView
         ],
      ), 
      Positioned( // кнопканы астына он жагына орналастырады 
              bottom: 20,
              right: 20,
              child: FloatingActionButton( //кнопка с иконкой touch_app
                onPressed: () {
                  Fluttertoast.showToast( //всплывающее уведомление 
                    msg: "Hello, Flutter!", // Текст уведомления
                    toastLength: Toast.LENGTH_SHORT, // ұзақтыгы 
                    gravity: ToastGravity.BOTTOM, // Расположение
                    backgroundColor: Colors.black54, // фондағы түс 
                    textColor: Colors.white, // текстын түсі 
                    fontSize: 16.0,
             );
           },
         child: Icon(Icons.touch_app),
            tooltip: "Показать Toast",
              ),
            ),
          ],
        ),
      ),
    );
  }
}                       // 2 тапсырма 
class ItemListView extends StatelessWidget {
  final List<String> items = List.generate(10, (index) => "Элемент ${index + 1}");
  @override                      //создает список из 10 элемент 
  Widget build(BuildContext context) {
    return ListView.builder( //динамически строит список 
      itemCount: items.length,
      itemBuilder: (context, index) {
        return ListTile( //стандарт элемент списка с иконкой 
          title: Text(items[index]), //  Заголовок элемента
          subtitle: Text("Описание ${index + 1}"), // Подзаголовок
          leading: Icon(Icons.star), // Иконка
        );
      },
    );
  }}
// 3 тапсырма  GridView с 6  түсті контейнерами
class ItemGridView extends StatelessWidget {
  final List<Color> colors = [ Colors.blue, Colors.yellow, Colors.green, Colors.orange, Colors.purple, Colors.red ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder( //сетка элементтов 
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount( // определяем сетку с 2 колонками 
        crossAxisCount: 2, // Две колонки
        crossAxisSpacing: 10,
        mainAxisSpacing: 10, ),
      itemCount: colors.length,
      itemBuilder: (context, index) {
        return Container( 
          color: colors[index], // Устанавливаем цвет контейнера
          child: Center(
            child: Text(
              "${index + 1}", style: TextStyle(fontSize: 24, color: Colors.white), // Номер внутри контейнера
            ),
          ),
        );
      },
    );
  }}
// 4 тапсырма  Экран с карточками (Card)
class CardsScreen extends StatelessWidget {
  final List<Map<String, String>> data = [ //список данных для карточек 
    {"title": "Заголовок 1", "description": "Описание 1", "image": "https://via.placeholder.com/150"},
    {"title": "Заголовок 2", "description": "Описание 2", "image": "https://via.placeholder.com/150"},];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Карточки")),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Card( //Card - карточка с изображением и текстом 
            child: Column( children: [
                Image.network(data[index]["image"]!), // Загружаем изображение из интернета
                ListTile( 
                  title: Text(data[index]["title"]!), // Заголовок карточки
                  subtitle: Text(data[index]["description"]!), // Описание карточки
                ),
              ],
            ),
          );
        },
      ),
    );
  }}
//5  тапсырма Drawer (боковое меню)
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [  DrawerHeader( //заголовок бокового меню 
       decoration: BoxDecoration(color: Colors.blue),
            child: Text("Меню", style: TextStyle(color: Colors.white, fontSize: 24)),
          ),
          ListTile( //элементы меню 
             leading: Icon(Icons.home),
               title: Text("Home"),
                 onTap: () => Navigator.pop(context), // Закрытие Drawer
         ),
          ListTile(leading: Icon(Icons.person),
            title: Text("Profile"),
              onTap: () {},
         ),
          ListTile( leading: Icon(Icons.settings),
            title: Text("Settings"),
              onTap: () {},
         ),
          ListTile( leading: Icon(Icons.logout),
            title: Text("Logout"),
              onTap: () {},
        ), ],
      ),
    );
  }
}