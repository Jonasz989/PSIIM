package backend.server.model.payload;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.awt.*;

@Data
@Getter
@Setter
public class GetAchievementDto {

    @JsonProperty("currentLocation")
    Point currentLocation;

    @JsonProperty("photo")
    byte[] photo;

    @JsonProperty("monumentId")
    long monumentId;

    @JsonProperty("userId")
    long userId;


}
