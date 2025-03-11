/**
 *	Le modèle.
 */
public class MyModel {
	/** Le nom. */
	private String m_name ;

	/** La vue. */
	private MyView m_view ;

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
	 *	Accesseur.
	 *	@return Le message.
	 */
	public String getMessage() {
		// TODO: On crée le message à partir du service et du nom courant
		return null ;
	}
	
	/**
	 *	Mutateur.
	 *	@param _name Le nom.
	 */
	public void setName(String _name) {
		m_name = _name ;
		// TODO: On notifie la vue
	}
	
	/**
	 *	Notifie la vue.
	 */
	public void notifyView() {
		// TODO: On met à jour la vue 
	}

	/**
	 *	Mutateur.
	 *	@param _view La vue.
	 */
	public void setView(MyView _view) {
		m_view = _view ;
	}	
}
