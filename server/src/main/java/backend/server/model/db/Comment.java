package backend.server.model.db;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.persistence.*;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;

@Data
@Entity(name = "comments")
@Getter
@Setter
public class Comment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @JsonProperty("userId")
    private long userId;

    @JsonProperty("monumentPoiId")
    private long monumentPoiId;

    @JsonProperty("text")
    private String text;

    @JsonProperty("date")
    private LocalDateTime date;



}
