package assign1;

/**
 * A very simple custom class, used to test <code>UnorderedArrayList</code>.
 *
 * @author Jeremy Audet &lt;ichimonji10@gmail.com&gt;
 */
public class Person {
    public String name;
    private int age;

    /**
     * Default constructor. Sets <code>name</code> to "" and age to 0.
     */
    public Person() {
        name = "";
        age = 0;
    }

    /**
     * Constructor. Sets <code>name</code> to <code>newName</code> and age to 0.
     *
     * @param newName
     */
    public Person(String newName) {
        name = newName;
        age = 0;
    }

    /**
     * Constructor. Sets <code>name</code> to <code>newName</code> and age to
     * <code>newAge</code>.
     *
     * <code>newAge</code> must be &gt;=0. Throws <code>BadAgeException</code>
     * if age cannot be set.
     *
     * @param newName
     * @param newAge
     */

    public Person(String newName, int newAge) {
        name = newName;
        setAge(newAge);
    }

    /**
     * Set age of person. Age must be &gt;=0.
     *
     * @param newAge The new age for the person.
     */
    public void setAge(int newAge) throws BadAgeException {
        if(newAge >= 0) {
            age = newAge;
        } else {
            throw new BadAgeException("Age cannot be less than 0: " + newAge);
        }
    }

    /**
     * Returns age of person.
     *
     * @return Age of person.
     */
    public int getAge() {
        return age;
    }

    /**
     * Returns a string representation of Person.
     *
     * @return Sample string representation: "("Alice", 15)"
     */
    public String toString() {
        return "(\"" + name + "\", " + age + ")";
    }
}
