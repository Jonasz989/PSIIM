package backend.server.model.payload;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.Column;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;


@Data
@Getter
@Setter
public class GetAchievementDto {

    @Column(name = "lon")
    @JsonProperty("lon")
    private double lon;

    @Column(name = "lat")
    @JsonProperty("lat")
    private double lat;

    @JsonProperty("photo")
    byte[] photo;

    @JsonProperty("monumentId")
    long monumentId;

    @JsonProperty("userId")
    long userId;


}
