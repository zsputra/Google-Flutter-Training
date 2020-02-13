


class ServiceA{

  int a = 4;

}

class ServiceB{
  ServiceA serviceA;

  ServiceB(this.serviceA);

  int add(){
    return serviceA.a+4;
  }

}