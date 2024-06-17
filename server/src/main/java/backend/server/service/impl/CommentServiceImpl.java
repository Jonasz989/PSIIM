package backend.server.service.impl;

import backend.server.model.db.Comment;
import backend.server.repository.CommentRepository;
import backend.server.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
public class CommentServiceImpl implements CommentService {

    private final CommentRepository commentRepository;
    private final AchievementServiceImpl achievementServiceImpl;

    @Autowired
    public CommentServiceImpl(CommentRepository commentRepository, AchievementServiceImpl achievementServiceImpl) {
        this.commentRepository = commentRepository;
        this.achievementServiceImpl = achievementServiceImpl;
    }

    public Optional<Comment> getCommentByIdAndMonumentId(long id, long monumentId) {
        return commentRepository.findByIdAndMonumentPoiId(id, monumentId);
    }

    public List<Comment> getCommentsByMonumentPoiId(int poiId) {
        return commentRepository.findCommentsByMonumentPoiIdOrderByDateAsc(poiId);
    }

    public Comment save(Comment comment) {

        if (!achievementServiceImpl.checkIfAchievementExistsByUserIdAndMonumentId(comment.getUserId(), comment.getMonumentPoiId())) {
            throw new IllegalArgumentException("You don't have permission to comment this monument");
        } else {
            return commentRepository.save(comment);
        }
    }

    public void deleteById(long id) {
        commentRepository.deleteById(id);
    }

    public Optional<Comment> findById(long id) {
        return commentRepository.findById(id);
    }

    public List<Comment> findAll() {
        return commentRepository.findAll();
    }




}
