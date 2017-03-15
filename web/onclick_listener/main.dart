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
  var btn = querySelector('#btn');
  var leakBtn = querySelector('#leak');
  StreamSubscription other;
  StreamSubscription ss;

  dartClassClosureFn(_) {
    print(variableInClosure);
  }

  leak(_) {
    btn.remove();
  }

  cleanupLeaks() {
    ss?.cancel();
    other?.cancel();
    btn = null;
    ss = null;
    other = null;
  }

  ss = btn.onClick.listen(dartClassClosureFn);
  other = leakBtn.onClick.listen(leak);
}
