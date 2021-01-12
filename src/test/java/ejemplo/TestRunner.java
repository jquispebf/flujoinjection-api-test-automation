package ejemplo;

import com.intuit.karate.junit5.Karate;

public class TestRunner {

	/*
	 * RUN ALL TESTS
	 * 
	 * @Karate.Test Karate testAll() { return Karate.run().relativeTo(getClass()); }
	 */
		
	/* RUN TEST BY TAG */
	@Karate.Test
	Karate testTags() {
		return Karate.run().tags("@ejemplo_database_01").relativeTo(getClass());
	}

}
