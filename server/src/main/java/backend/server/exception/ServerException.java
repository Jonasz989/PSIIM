package backend.server.exception;

import org.springframework.http.HttpStatus;

public class ServerException extends RuntimeException {

    private HttpStatus status;
    private String message;

    public ServerException(HttpStatus status, String message) {
        this.status = status;
        this.message = message;
    }

    public ServerException(String message, HttpStatus status, String message1) {
        super(message);
        this.status = status;
        this.message = message1;
    }

    public HttpStatus getStatus() {
        return status;
    }

    @Override
    public String getMessage() {
        return message;
    }
}