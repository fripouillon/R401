/**
 *	Le contrôleur.
 */
public class MyController {
	/** Le modèle. */
	private MyModel m_model ;

	/** La vue. */
	private MyView m_view ;
	
	/**
	 *	Dit bonjour.
	 */
	public void sayHello() {
		// TODO: On récupère les paramètres d'entrée 
		// TODO: On modifie les données du modèle 
	}

	/**
	 *	Mutateur.
	 *	@param _model Le modèle.
	 */
	public void setModel(MyModel _model) {
		m_model = _model ;
	}
	
	/**
	 *	Mutateur.
	 *	@param _view La vue.
	 */
	public void setView(MyView _view) {
		m_view = _view ;
	}
}
