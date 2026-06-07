const jsonHeaders = {
  "content-type": "application/json; charset=utf-8",
};

Deno.serve(async (request: Request) => {
  const url = new URL(request.url);
  const path = url.pathname.replace(/^\/v1/, "");

  if (request.method === "GET" && path === "/health") {
    return Response.json(
      { status: "ok", apiVersion: "0.1.0" },
      { headers: jsonHeaders },
    );
  }

  return Response.json(
    {
      error: "not_implemented",
      message: "Authenticated profile routes are defined in the API contract and land in the next backend increment.",
    },
    { status: 501, headers: jsonHeaders },
  );
});
