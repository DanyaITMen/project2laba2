package com.example.demo.repository;

import com.example.demo.model.MatchResult;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface MatchResultRepository extends CrudRepository<MatchResult, Long> {
}
