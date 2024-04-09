package backend.server.exception;

import lombok.Getter;
import org.springframework.http.HttpStatus;

@Getter
public class ServerException extends RuntimeException {

    private final HttpStatus status;
    private final String message;

    public ServerException(HttpStatus status, String message) {
        this.status = status;
        this.message = message;
    }


    @Override
    public String getMessage() {
        return message;
    }
}