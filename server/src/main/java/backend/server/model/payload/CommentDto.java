package backend.server.model.payload;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;


@Data
@Getter
@Setter
public class CommentDto {

    @JsonProperty("userId")
    private long userId;

    @JsonProperty("monumentPoiId")
    private long monumentPoiId;

    @JsonProperty("text")
    private String text;

}
