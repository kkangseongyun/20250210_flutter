main() {

  //named parameter....
  //optional 로 선언하면.. nullable 이던가.. 아니면.. default 값을 지정하던가..
  void f1(bool arg1, {String arg2 = 'hello', int? arg3}){}
  f1(true);
  // f1(true, 'world', 20);//error... named parameter 는 값을 지정하려면 무조건 이름을 명시해야..
  f1(true, arg2: 'hello');
  f1(true, arg3: 20, arg2: 'world');//이름이 명시됨으로.. 순서는 의미가 없다..

  //positional parameter...
  void f2(bool arg1, [String arg2 = 'hello', int? arg3]){}
  f2(true);
  // f2(true, arg2: 'world', arg3: 20);//error...이름 명시할 수 없다..
  // f2(true, 20, 'hello');//이름이 명시되지 않음으로 순서에 맞추어서....
  f2(true, 'world');
  f2(true, 'world', 20);
}