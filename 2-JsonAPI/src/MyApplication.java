import java.io.StringReader;

import jakarta.json.Json ;
import jakarta.json.JsonArray ;
import jakarta.json.JsonObject ;
import jakarta.json.JsonReader ;

public class MyApplication {
	/**
	 *	Lance l'application.
	 * 	@param _args Les arguments.
	 */
	public static void main(String[] _args) {
        String jsonString = create() ;
        System.out.println(jsonString) ;
        parse(jsonString) ;
	}

	/**
	 *	Créée le Json.
	 * 	@return La chaîne du Json.
	 */
    private static String create() {
    }

	/**
	 *	Parcours le Json.
	 * 	@param _jsonString La chaîne du Json.
	 */
    private static void parse(String _jsonString) {
    }
}
