/** La websocket. */
var socket = null ;

/** Le nom de l'utilisateur. */
var username = null ;

/**
 *	Réagit à une connexion.
 *	@param _event L'événement.  
 */
function whenLogged(_event) {
	if (socket != null) {
	// TODO: On notifie l'utilisateur qu'il est connecté
	// TODO: On cache le champ de texte et le bouton [Se connecter]
	// TODO: On affiche le champ de texte et les boutons [Envoyer] et [Se déconnecter]
	}
}

/**
 *	Réagit à une déconnexion.
 *	@param _event L'événement.  
 */
function whenUnlogged(_event) {
	if (socket != null) {
	// TODO: On notifie l'utilisateur qu'il est déconnecté
	// TODO: On affiche le champ de texte et le bouton [Se connecter]
	// TODO: On cache le champ de texte et les boutons [Envoyer] et [Se déconnecter]
	}	
}

/**
 *	Réagit à la réception d'un message.
 *	@param _event L'événement.  
 */
function whenReceived(_event) {
	if (socket != null) {
	// TODO: On notifie l'utilisateur qu'un nouvel utilisateur est connecté | déconnecté ou qu'un utilisateur a envoyé un message
	// On rappelle que le message WebSocket est stocké dans _event.data et on suppose ici qu'il s'agit d'un JSON de la forme 
	//       { what : 'logged | unlogged | message', who : 'username', content : 'le texte si c'est un message' }
	}
}

/**
 *	Connecte.
 */
function onLogin() {
	// TODO: On instantie socket et username. 
	// TODO: La variable socket est reliée aux bons événements via socket.addEventListener(...) 
	// La socket pointera vers ‘ws://localhost:8080/ChatApp/WebSocket/{username}’ où {username} est la valeur de la variable username.
}

/**
 *	Déconnecte.
 */
function onLogout() {
	if (socket != null) {
	// TODO: On ferme la connextion
	}
}

/**
 *	Envoie.
 */
function onSend() {
	if (socket != null) {
	// TODO: On envoie le message
	// On suppose que le message ne contient que le texte
	}	
}
