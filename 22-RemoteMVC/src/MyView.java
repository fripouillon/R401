import javafx.scene.control.TextField ;
import javafx.scene.control.Label ;

import java.io.IOException ;
import java.io.InputStream ;
import java.io.Reader ;

import java.net.HttpURLConnection ;
import java.net.URL ;
import java.net.URI ;

import jakarta.json.Json ;
import jakarta.json.JsonObject ;
import jakarta.json.JsonReader ;

import javafx.event.ActionEvent ;
import javafx.fxml.* ;

/**
 *	La vue.
 */
public class MyView {
	@FXML
	private TextField m_input ;
	@FXML
	private Label m_output ;

	/**
	 *	Réagit à l'action de l'utilisateur.
	 *	@param _event L'événement.
	 */
	@FXML
	private void handleSayHello(ActionEvent _event) throws IOException {
		// Le contrôleur est sur le serveur
	    URL controller = URI.create("http://localhost:8080/WebMVC/controller?name=" + getInput()).toURL() ; 

		// On délègue l'action au contrôleur sur le serveur...
		// TODO: On ouvre la connexion au modèle qui va répondre (model est de type HttpURLConnection et est récupéré à partir de l'URL de controller)
		// TODO: On paramètre la connexion au modèle (méthode POST, etc.)
		// TODO: On se connecte

		// On met à jour la vue à partir du modèle
	    this.update(model) ;
	}	

	/**
	 *	Met à jour la sortie.
	 *	@param _model Le modèle.
	 */
	public void update(HttpURLConnection _model) throws IOException {
		// TODO: On change le contenu du label de sortie à partir du message dans _model
	}

	
	/**
	 *	Accesseur.
	 *	@return Le texte d'entrée.
	 */
	public String getInput() {
		// TODO: On récupère les paramètres d'entrée à partir du nom du champ de texte 
		return null ;
	}

}
