package backend.server.model.payload;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Setter
@Getter
public class RankingDto {

    @JsonProperty("name")
    String name;

    @JsonProperty("points")
    long points;

    @JsonProperty("position")
    long position;

    public RankingDto(String name, long points, long position) {
        this.name = name;
        this.points = points;
        this.position = position;
    }

}
