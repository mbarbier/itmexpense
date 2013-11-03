part of events;

class E  {
  
  static E _e;
  
  EventBus eventBus;
  
  final EventType<CreateAccountPlace> createAccountPlace = new EventType<CreateAccountPlace>();
  final EventType<AccountCreatedPlace> accountCreatedPlace = new EventType<AccountCreatedPlace>();
  final EventType<ViewAccountPlace> viewAccountPlace = new EventType<ViewAccountPlace>();
  final EventType<ViewAccountEntriesPlace> viewAccountEntriesPlace = new EventType<ViewAccountEntriesPlace>();
  
  static E get() {
    if (_e == null) {
      _e = new E._create();
    }
    return _e;
  }
  
  E._create() {
    eventBus = new SimpleEventBus();
  }
  
  static EventBus rootEventBus() {
    return get().eventBus;
  }

}

class Place {}
class CreateAccountPlace extends Place {}
class AccountCreatedPlace extends Place {
  Account account;
}
class ViewAccountPlace extends Place {
  Account account;
}
class ViewAccountEntriesPlace extends Place {
  Account account;
}
