package backend.server.repository;

import backend.server.model.db.Comment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface CommentRepository extends JpaRepository<Comment, Long> {

    Optional<Comment> findByIdAndMonumentPoiId(long id, long monumentPoiId);

    @Query("SELECT c FROM comments c WHERE c.monumentPoiId = ?1 ORDER BY c.date ASC")
    List<Comment> findCommentsByMonumentPoiIdOrderByDateAsc(long monumentPoiId);

}
