package backend.server.controller;

import backend.server.model.db.Comment;
import backend.server.model.payload.CommentDto;
import backend.server.service.impl.CommentServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/api")
public class CommentController {

    private final CommentServiceImpl commentServiceImpl;

    @Autowired
    public CommentController(CommentServiceImpl commentServiceImpl) {
        this.commentServiceImpl = commentServiceImpl;
    }

    @GetMapping("/comments")
    public List<Comment> findAll() {
        return commentServiceImpl.findAll();
    }

    @GetMapping("/comments/{commentId}")
    public Optional<Comment> findById(@PathVariable Integer commentId) {
        return commentServiceImpl.findById(commentId);
    }

    @PostMapping("/comments")
    public Comment save(@RequestBody CommentDto commentDto) {

        Comment comment = new Comment();
        comment.setUserId(commentDto.getUserId());
        comment.setMonumentPoiId(commentDto.getMonumentPoiId());
        comment.setText(commentDto.getText());
        comment.setDate(LocalDateTime.now());

        return commentServiceImpl.save(comment);
    }

    @DeleteMapping("/comments/{commentId}")
    public void deleteById(@PathVariable Integer commentId) {
        commentServiceImpl.deleteById(commentId);
    }
}
