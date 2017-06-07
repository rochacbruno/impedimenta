public class Box<T> {
    private T contents;

    public void set(T contents) {
        this.contents = contents;
    }

    public T get() {
        return contents;
    }

    public <U extends Number> String inspect(U other){
        return "T: " + contents.getClass().getName() + "\n"
             + "U: " + other.getClass().getName();
    }
}
