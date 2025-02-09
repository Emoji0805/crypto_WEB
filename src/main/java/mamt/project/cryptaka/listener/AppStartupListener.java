package mamt.project.cryptaka.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

import mamt.project.cryptaka.utils.HistoriqueEchangeListener;
import mamt.project.cryptaka.utils.HistoriqueTransactionListener;

@WebListener
public class AppStartupListener implements ServletContextListener {
    private HistoriqueTransactionListener transactionListener;
    private HistoriqueEchangeListener echangeListener;
    @Override
    public void contextInitialized(ServletContextEvent sce) {
//        transactionListener = new HistoriqueTransactionListener();
//        transactionListener.startListening();
//
//        echangeListener = new HistoriqueEchangeListener();
//        echangeListener.startListening();
//
//        System.out.println("🚀 Firestore Listener démarré !");
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        if (transactionListener != null) {
            transactionListener.stopListening();
        }
    }
}