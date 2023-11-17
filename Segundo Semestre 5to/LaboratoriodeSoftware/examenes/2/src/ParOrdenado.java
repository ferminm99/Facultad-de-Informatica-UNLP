public class ParOrdenado <X,Y> {
        private X a;
        private Y b;
        public ParOrdenado (X a, Y b){
            this.a=a;
            this.b=b;
        }
        public X getA() {   return a; }
        public void setA(X a) {   this.a = a; }
        public Y getB() {  return b; }
        public void setB(Y b) {   this.b = b; }

    @Override
    public String toString() {
        return a.toString() + b.toString();
    }
}
