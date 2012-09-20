package hw1;
import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;

/**
 * A very simple custom class, used to test <code>UnorderedArrayList</code>.
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
     * @param newName
     */
    public Person(String newName) {
        name = newName;
        age = 0;
    }

    /**
     * Constructor. Sets <code>name</code> to <code>newName</code> and age to
     * <code>newAge</code>.
     * @param newName
     * @param newAge Throws <code>PersonAgeException</code> if age &gt;= 0.
     */
    public Person(String newName, int newAge) throws PersonAgeException {
        name = newName;
        setAge(newAge);
    }

    /**
     * Set age of person. Age must be &gt;=0.
     * @param newAge The new age for the person.
     */
    public void setAge(int newAge) throws PersonAgeException {
        if(newAge >= 0) {
            age = newAge;
        } else {
            throw new PersonAgeException("Age cannot be less than 0: " + newAge);
        }
    }

    /**
     * Returns age of person.
     * @return Age of person.
     */
    public int getAge() {
        return age;
    }

    /**
     * Returns a string representation of Person.
     * @return Sample string representation: "("Alice", 15)"
     */
    public String toString() {
        return "(\"" + name + "\", " + age + ")";
    }

    @Override
    public int hashCode() {
        // you pick a hard-coded, randomly chosen, non-zero, odd number ideally
        // different for each class
        return new HashCodeBuilder(403, 547).
            append(age).
            append(name).
            toHashCode();
    }

    @Override
    public boolean equals(Object other) {
        if(other == this)
            return true;
        if(other == null)
            return false;
        if(other.getClass() != this.getClass())
            return false;

        Person otherPerson = (Person)other;
        return new EqualsBuilder().
            //appendSuper(super.equals(other)). // only if this is subclass
            append(age, otherPerson.age).
            append(name, otherPerson.name).
            isEquals();
    }
}
