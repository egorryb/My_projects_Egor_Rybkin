package HTTP

import (
	"FirstHTTP/jsonwork"
	"encoding/json"
	"fmt"
	"log"
	"net/http"

	"github.com/go-chi/chi/v5"
	"github.com/google/uuid"
)

type Storage interface {
	Get(key string) (*jsonwork.Photo, error)
	Put(key string, value jsonwork.Photo) error
	//Post(key string, value string) error
}

type Server struct {
	storage Storage
}

func newServer(str Storage) *Server {
	return &Server{storage: str}
}

func (s *Server) getHandler(w http.ResponseWriter, r *http.Request) {
	key := r.URL.Query().Get("key")
	if key == "" {
		http.Error(w, "Missing key", http.StatusBadRequest)
		return
	}
	value, err := s.storage.Get(key)
	if err != nil {
		http.Error(w, "Key not found", http.StatusNotFound)
		return
	}
	_, _ = fmt.Fprint(w, *value)

	//w.Write([]byte("Hello Egor"))
}

func (s *Server) putHandler(w http.ResponseWriter, r *http.Request) {
	key := uuid.New().String()
	var data jsonwork.Photo
	if err := json.NewDecoder(r.Body).Decode(&data); err != nil {
		log.Printf("Invalid request")
		http.Error(w, "Invalid request", http.StatusBadRequest)
		return
	}
	// value, okKey := data["key"]
	//value, okValue := data["value"]
	// if !okKey || !okValue {
	// 	log.Printf("PUT missing key")
	// 	http.Error(w, "Missing key or value", http.StatusBadRequest)
	// 	return
	// }
	// if !okKey	 {
	// 	log.Printf("PUT missing key")
	// 	http.Error(w, "Missing key or value", http.StatusBadRequest)
	// 	return
	// }
	err := s.storage.Put(key, data)
	if err != nil {
		log.Printf("Can not store")
		http.Error(w, "Failed to store value", http.StatusInternalServerError)
		return
	}
	// Возвращаем успешный ответ с Location заголовком
	w.Header().Set("Location", "/object/"+key)
	w.WriteHeader(http.StatusCreated)

	//log.Printf("PUT request successful - key: '%s', value: '%s'", key, value)
}

func CreateAndRunServer(storage Storage, addr string) error {
	server := newServer(storage)

	r := chi.NewRouter()

	r.Route("/task", func(r chi.Router) {
		r.Put("/", server.putHandler)
	})
	r.Route("/task", func(r chi.Router) {
		r.Get("/status/", server.getHandler)
		r.Get("/result", server.getHandler)
	})
	return http.ListenAndServe(addr, r)
}

//w.Write([]byte("Hello Egor"))
