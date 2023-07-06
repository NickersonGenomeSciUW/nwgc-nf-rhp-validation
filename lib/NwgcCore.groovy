//
// This file holds several functions specific to the workflow/rnaseq.nf in the nf-core/rnaseq pipeline
//

import nextflow.Nextflow
import java.util.concurrent.CopyOnWriteArrayList
import com.rabbitmq.client.ConnectionFactory
import com.rabbitmq.client.Connection
import com.rabbitmq.client.Channel

class NwgcCore {

    private static Connection connection
    private static Channel channel
    private static String QUEUE_NAME = "nextflow";
    private static CopyOnWriteArrayList<String> messages = new CopyOnWriteArrayList<>();

    NwgcCore() {}

    public static void init(params) {
        ConnectionFactory factory = new ConnectionFactory();
        factory.setHost(params.rabbitHost);
        factory.setUsername("nf");
        factory.setPassword("nf");
        
        try {
            connection = factory.newConnection()
            channel = connection.createChannel()
            channel.queueDeclare(QUEUE_NAME, true, false, false, null);
        } catch (Exception e) {
            println e
        }
        
    }

    public static void publishMessage(workflow, String message, session) {
        try {
            if (channel != null) {
                channel.basicPublish("", QUEUE_NAME, null, buildMessage(workflow, message, session).getBytes())
            }
        } catch (Exception e) {
            println e
        }
    }

    public static String buildMessage(workflow, String message, session) {
        return """
        {
            "message": "${message}"
            "launchDir": "${workflow.launchDir}"
            "session": "${session.getStatsObserver().getStats().toString()}
        }
        """;
    }

    /***
     * This is called even if the process errors out
     */
    public static void processComplete(workflow) {
        if (connection != null && connection.isOpen() && workflow.success) {
            publishMessage(workflow, "process completed successfully")
            connection.close()
        }
    }

    public static void error(workflow) {
        publishMessage(workflow, "error")
    }
}