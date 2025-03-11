import java.io.IOException;

import jakarta.servlet.ServletException ;
import jakarta.servlet.ServletResponse ;

/**
 *	Le modèle.
 */
public class MyModel {
	/** Le nom. */
	private String m_name ;

	/** Le service. */
	private final MyService m_service ;
	
	/**
	 *	Constructeur.
	 */
	public MyModel() {
		this(new MyService()) ;
	}
	
	/**
	 *	Constructeur.
	 *	@param _service Le service.
	 */
	public MyModel(MyService _service) {
		m_service = _service ;
	}
	
	/**
	 *	Mutateur.
	 *	@param _name Le nom.
	 *	@param _response La réponse.
	 */
	public void setName(String _name, ServletResponse _response) throws ServletException, IOException {
		m_name = _name ;
		// TODO: On notifie la vue
	}

	/**
	 *	Accesseur.
	 *	@return Le message.
	 */
	public String getMessage() {
		// TODO: On crée le message à partir du service et du nom courant
		return null ;
	}
	
	/**
	 *	Notifie la réponse.
	 *	@param _response La réponse.
	 */
	public void notifyView(ServletResponse _response) throws ServletException, IOException {
		// TODO: On met à jour la vue 
	}
}
