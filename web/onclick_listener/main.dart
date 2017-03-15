import 'dart:async';
import 'dart:html';

class Aaaargh {
  String name;
  Aaaargh(this.name);

  @override
  String toString() => '(Aaaargh:$name)';
}

main() {
  var variableInClosure = new Aaaargh("I'm in a closure");
  var addButton = querySelector('#addBtn');
  var leakButton = querySelector('#leakBtn');
  StreamSubscription leakButtonClickSubscription;
  StreamSubscription addButtonClickSubscription;

  dartClassClosureFn(_) {
    print(variableInClosure);
  }

  cleanupLeaks() {
    addButtonClickSubscription?.cancel();
    leakButtonClickSubscription?.cancel();
    addButton = null;
    addButtonClickSubscription = null;
    leakButtonClickSubscription = null;
  }

  leak(_) {
    addButton.remove();
    // uncomment to clean up the memory leaks
    // cleanupLeaks();
  }
  
  addButtonClickSubscription = addButton.onClick.listen(dartClassClosureFn);
  leakButtonClickSubscription = leakButton.onClick.listen(leak);
}
