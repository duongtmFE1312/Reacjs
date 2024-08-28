const express = require("express");
const cors = require("cors");
const mysql = require("mysql");
const app = express();

const jwt = require("node-jsonwebtoken");
const fs = require("fs");
const PRIVATE_KEY = fs.readFileSync("private-key.txt");

app.use([cors(), express.json()]);

// Create a connection pool
const db = mysql.createConnection({
  host: "localhost",
  user: "root",
  password: "",
  port: 3306,
  database: "db_shoestrend",
});
db.connect((err) => {
  if (err) throw err;
  console.log("Da ket noi database");
});

app.get("/admin/user", (req, res) => {
  let sql = `SELECT * FROM user`;
  db.query(sql, (err, data) => {
    if (err) {
      res.json({ thongbao: "loi lay user", err });
    } else {
      res.json(data);
    }
  });
});

app.post("/login", function(req, res) {
  const un = req.body.un;
  const pw = req.body.pw;
  if (checkUserPass(un, pw)==true) {
    const userInfo = getUserInfo(un);
    const jwtBearToken = jwt.sign({},
      PRIVATE_KEY, { expiresIn:120, subject: userInfo.id}
    );
    res.status(200).json({token:jwtBearToken, expiresIn:120, userInfo: userInfo})
  }
  else res.status(401).json({thongbao:"Đăng nhập thất bại"})
})

const checkUserPass = (un, pw) => {
  if (un=="aa" && pw=="123") return true;
  if (un=="bb" && pw=="321") return true;
  return false;
}

const getUserInfo = (username) =>{
  if (username=="aa") return {"id":"1", "hoten":"Nguyễn Văn A"};
  if (username=="bb") return {"id":"2", "hoten":"Nguyễn Văn b"};
  return {"id":"-1", "hoten":""};
}


// Fetch products with optional limit
app.get("/product/:limi?", (req, res) => {
  let limi = parseInt(req.params.limi || 8);
  let sql = `SELECT * FROM product ORDER BY created_at LIMIT 0, ?`;
  db.query(sql, [limi], (err, data) => {
    if (err) {
      res.json({ thongbao: "loi lay sp", err });
    } else {
      res.json(data);
    }
  });
});

// Product hot
app.get("/productNew/:limi?", (req, res) => {
  let limi = parseInt(req.params.limi || 8);
  let sql = `SELECT * FROM product WHERE news = 1 ORDER BY created_at LIMIT 0, ?`;
  db.query(sql, [limi], (err, data) => {
    if (err) {
      res.json({ thongbao: "loi lay sp hot", err });
    } else {
      res.json(data);
    }
  });
});

// Product sale
app.get("/productSale/:limi?", (req, res) => {
  let limi = parseInt(req.params.limi || 8);
  let sql = `SELECT * FROM product WHERE sale = 1 ORDER BY created_at LIMIT 0, ?`;
  db.query(sql, [limi], (err, data) => {
    if (err) {
      res.json({ thongbao: "loi lay sp sale", err });
    } else {
      res.json(data);
    }
  });
});

// Fetch product details by id
app.get("/productDetail/:id", (req, res) => {
  let id = parseInt(req.params.id || 0);
  if (isNaN(id) || id <= 0) {
    res.json({ "thong bao": "Không biết sản phẩm", id: id });
    return;
  }
  let sql = `SELECT product.*, catalog.name as catalog_name FROM product JOIN catalog ON product.id_catalog = catalog.id WHERE product.id = ?`;
  db.query(sql, [id], (err, data) => {
    if (err) {
      res.json({ thongbao: "Lỗi lấy 1 sp", err });
    } else {
      res.json(data[0]);
    }
  });
});

// Fetch products by catalog id
app.get("/productCatalog/:id_catalog/:limi?", (req, res) => {
  let limi = parseInt(req.params.limi || 6);
  let id_catalog = parseInt(req.params.id_catalog);
  if (isNaN(id_catalog) || id_catalog <= 0) {
    res.json({ "thong bao": "Không biết loai", id_catalog: id_catalog });
    return;
  }
  let sql = `SELECT * FROM product WHERE id_catalog = ? ORDER BY id desc LIMIT 0, ?`;
  db.query(sql, [id_catalog, limi], (err, data) => {
    if (err) {
      res.json({ thongbao: "Lỗi lấy sp trong loai", err });
    } else {
      res.json(data);
    }
  });
});

// Fetch catalog details by id
app.get("/catalog/:id_catalog", (req, res) => {
  let id_catalog = parseInt(req.params.id_catalog);
  if (isNaN(id_catalog) || id_catalog <= 0) {
    res.json({ "thong bao": "Không biết loai", id_catalog: id_catalog });
    return;
  }
  let sql = `SELECT * FROM catalog WHERE id = ?`;
  db.query(sql, [id_catalog], (err, data) => {
    if (err) {
      res.json({ thongbao: "Lỗi lấy loai", err });
    } else {
      res.json(data[0]);
    }
  });
});

// Fetch all catalogs
app.get("/catalog", (req, res) => {
  let sql = `SELECT * FROM catalog ORDER BY id `;
  db.query(sql, (err, data) => {
    if (err) {
      res.json({ thongbao: "Lỗi lấy loai", err });
    } else {
      res.json(data);
    }
  });
});

// Fetch related products by product id
app.get("/productRelated/:id", (req, res) => {
  let id = parseInt(req.params.id || 0);
  if (isNaN(id) || id <= 0) {
    res.json({ "thong bao": "Không biết sản phẩm", id: id });
    return;
  }

  db.query(
    "SELECT id_catalog FROM product WHERE id = ?",
    [id],
    (err, categoryData) => {
      if (err) {
        res.json({ thongbao: "Lỗi xảy ra khi lấy dữ liệu", err });
      } else if (categoryData.length === 0) {
        res.json({ thongbao: "Không tìm thấy sản phẩm" });
      } else {
        const id_catalog = categoryData[0].id_catalog;
        db.query(
          "SELECT * FROM product WHERE id_catalog = ? AND id != ?",
          [id_catalog, id],
          (err, relatedData) => {
            if (err) {
              res.json({ thongbao: "Lỗi xảy ra khi lấy dữ liệu", err });
            } else {
              res.json(relatedData);
            }
          }
        );
      }
    }
  );
});

app.post("/orders", (req, res) => {
  let data = req.body;
  let sql = `INSERT INTO orders SET ?`;
  db.query(sql, data, (err, result) => {
    if (err) {
      res.json({ id: -1, thongbao: "Loi luu don hang", err });
    } else {
      const id = result.insertId;
      res.json({ id: id, thongbao: "da luu don hang" });
    }
  });
});

app.post("/order_detail", (req, res) => {
  let data = req.body;
  let sql = `INSERT INTO order_detail SET ?`;
  db.query(sql, data, (err, result) => {
    if (err) {
      res.json({ thongbao: "Loi luu don hang chi tiet", err });
    } else {
      res.json({
        product_id: data.product_id,
        thongbao: "da luu don hang chi tiet",
      });
    }
  });
});

app.get("/admin/product", function (req, res) {
  let sql = `SELECT * FROM product ORDER BY id desc `;
  db.query(sql, (err, data) => {
    if (err) res.json({ thongbao: "Lỗi lấy danh sách sản phẩm", err });
    else res.json(data);
  });
});

app.get("/admin/product/:id", function (req, res) {
  let id = parseInt(req.params.id);
  if (id <= 0) {
    res.json({ thongbao: "Không biết sản phẩm", id: id });
    return;
  }
  let sql = `SELECT * FROM product WHERE id = ? `;
  db.query(sql, id, (err, data) => {
    if (err) res.json({ thongbao: "Lỗi lấy 1 sản phẩm", err });
    else res.json(data[0]);
  });
});

app.post("/admin/product", function (req, res) {
  let data = req.body;
  let sql = "INSERT INTO product SET ?";
  db.query(sql, data, (err, data) => {
    if (err) res.json({ thongbao: "Lỗi thêm 1 sản phẩm", err });
    else res.json({ thongbao: "Đã thêm 1 sản phẩm", id: data.insertId });
  });
});

app.put("/admin/product/:id", function (req, res) {
  let data = req.body;
  let id = req.params.id;
  let sql = "UPDATE product SET ? WHERE id = ?";
  db.query(sql, [data, id], (err, data) => {
    if (err) res.json({ thongbao: "Lỗi cập nhật sản phẩm", err });
    else res.json({ thongbao: "Đã cập nhật sản phẩm" });
  });
});

app.delete("/admin/product/:id", function (req, res) {
  let id = req.params.id;
  let sql = "DELETE FROM product WHERE id = ?";
  db.query(sql, id, (err, data) => {
    if (err) res.json({ thongbao: "Lỗi xóa sản phẩm", err });
    else res.json({ thongbao: "Đã xóa sản phẩm" });
  });
});

app.get("/admin/catalog", function (req, res) {
  let sql = `SELECT * FROM catalog ORDER BY id desc `;
  db.query(sql, (err, data) => {
    if (err) res.json({ thongbao: "Lỗi lấy danh sách danh mục", err });
    else res.json(data);
  });
});

app.get("/admin/catalog/:id", function (req, res) {
  let id = parseInt(req.params.id);
  if (id <= 0) {
    res.json({ thongbao: "Không biết danh mục", id: id });
    return;
  }
  let sql = `SELECT * FROM catalog WHERE id = ? `;
  db.query(sql, id, (err, data) => {
    if (err) res.json({ thongbao: "Lỗi lấy 1 danh mục", err });
    else res.json(data[0]);
  });
});

app.post("/admin/catalog", function (req, res) {
  let data = req.body;
  let sql = "INSERT INTO catalog SET ?";
  db.query(sql, data, (err, data) => {
    if (err) res.json({ thongbao: "Lỗi thêm 1 danh mục", err });
    else res.json({ thongbao: "Đã thêm 1 danh mục", id: data.insertId });
  });
});

app.put("/admin/catalog/:id", function (req, res) {
  let data = req.body;
  let id = req.params.id;
  let sql = "UPDATE catalog SET ? WHERE id = ?";
  db.query(sql, [data, id], (err, data) => {
    if (err) res.json({ thongbao: "Lỗi cập nhật danh mục", err });
    else res.json({ thongbao: "Đã cập nhật danh mục" });
  });
});

app.delete("/admin/catalog/:id", function (req, res) {
  let id = req.params.id;
  
  let sql = "DELETE FROM catalog WHERE id = ?";
  db.query(sql, id, (err, data) => {
    if (err) res.json({ thongbao: "Lỗi xóa danh mục", err });
    else res.json({ thongbao: "Đã xóa danh mục" });
  });
});
app.listen(3000, () => console.log(`Ung dung dang chay voi port 3000`));
