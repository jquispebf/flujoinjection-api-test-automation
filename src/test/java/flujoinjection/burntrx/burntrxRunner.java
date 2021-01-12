package flujoinjection.burntrx;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.junit4.Karate;
import org.junit.runner.RunWith;

@RunWith(Karate.class)
@KarateOptions(features = "classpath:flujoinjection/burntrx/burntrx.feature")
public class burntrxRunner {
}
