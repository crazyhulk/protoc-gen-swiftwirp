package main

import (
	"context"
	"log"
	"math/rand"
	"net/http"
	"time"

	"protoc-gen-swiftwirp/example/cmd/haberdasher"

	"github.com/golang/protobuf/ptypes"
	"github.com/twitchtv/twirp"
)

type randomHaberdasher struct{}

func (h *randomHaberdasher) BuyHat(ctx context.Context, hat *haberdasher.Hat) (*haberdasher.Hat, error) {
	return hat, nil
}

func (h *randomHaberdasher) MakeHat(ctx context.Context, size *haberdasher.Size) (*haberdasher.Hat, error) {
	if int(size.Inches) <= 0 {
		return nil, twirp.InvalidArgumentError("Inches", "must be a positive number greater than zero")
	}

	ts, err := ptypes.TimestampProto(time.Now())
	if err != nil {
		return nil, err
	}

	return &haberdasher.Hat{
		Size:  size.Inches,
		Color: []string{"white", "black", "brown", "red", "blue"}[rand.Intn(4)],
		Name:  []string{"bowler", "baseball cap", "top hat", "derby"}[rand.Intn(3)],
		AvailableSizes: []*haberdasher.Size{
			{Inches: 10},
			{Inches: 20},
		},
		Roles: []int32{
			1,
			2,
			3,
		},
		CreatedOn: ts,
	}, nil
}

func main() {
	server := haberdasher.NewHaberdasherServer(&randomHaberdasher{}, nil)
	log.Fatal(http.ListenAndServe(":9000", server))
}
