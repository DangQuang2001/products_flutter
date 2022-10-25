import 'dart:html';

import 'package:flutter/material.dart';
import 'package:project_learning_g1/View/genre.dart';
import 'package:project_learning_g1/View/slideimage.dart';

class Exam extends StatelessWidget {
  const Exam({Key? key}) : super(key: key);
  final String src =
      "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBwgHBgkIBwgKCgkLDRYPDQwMDRsUFRAWIB0iIiAdHx8kKDQsJCYxJx8fLT0tMTU3Ojo6Iys/RD84QzQ5OjcBCgoKDQwNGg8PGjclHyU3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3Nzc3N//AABEIAIYAawMBIgACEQEDEQH/xAAcAAACAgMBAQAAAAAAAAAAAAAFBgQHAAEDAgj/xAA7EAACAQMCAwUFBwIGAwEAAAABAgMABBEFIRIxQQYTUWFxIjKBkaEHFEKxwdHwI1IVM2Ki4fFDkrIk/8QAGAEAAwEBAAAAAAAAAAAAAAAAAQIDBAD/xAAcEQACAwEBAQEAAAAAAAAAAAAAAQIDESExEiL/2gAMAwEAAhEDEQA/AGCVGTmK5g8qJalqsd9bovcRRsvVBjNCS4wKyJmjDsZAikk4A60t6zr5VWFuQFH4vGs7QakMNAj8KIMyt+lIl/eS3tzwxZCrtinj0DJVzf3Go3BhSYs7NuQ3IVEv4WtZTGJXkjViOLPnXu0ElpGQBmQ7sx6VzklkY4brzpwBHTpJuBeHicHxGc+hozbXs8XC8cnDv7LeP88KE6Q/dRMpGwGc+Aqcl9CZwjYwxx8eh/SmxCpsbtK16OdhBeYil5B/wsf0NHKr6VAh4DyOy/tR3s7rBPBZ3Tb8opD1/wBJ8/CkccDoyVusFbFA49LXTFeBXscq7AC53lc7q47mDvDv4eZrhJIVQnbbxOKG9qbhbe3jw6tI2fd2AwPD41JvuFoxbWgDW7hrmQwxNkFiWPj4n+eBol2e7PjuFndfeYYyOlAtPzNcxRLuznHoP+atFES3so18B+lNJ5xDQjvWJd9pwZ7llX3UB5f6v2xQ9dNLk7bYz9abyiuJUGMtGB9KhJEqlTjO1NFnOILhsD3J7pcsozjFLl/xJIwIx04fD+fpTxZssN2gIwOLfNQO2ujhI/vVuM9Tj5/z1pvvuE/jmkDR78ahpntnMsZ4H8/A/LFajuOGQ8Zyc426j96XNJuPuWsFQcRTr9eYP50Vum9vjBxnZvXpTsRFmaBqAvrQB3DSx7E/3DoaLKM1WXZXVvul8gk2VjhvT/urOjIYAjcGkOZ0Ar1w1sCt0QCJLKFUltx4eNJuuTspMRbKpsoxyHPH150zOxmbb3FPzpL1iYSzTuDsWIH6VLOlosL9ljb/AOII88qpgDHEcfzpViajJG1opifPsHBU1VeiXVjCS+ocQRdsjpTlaPAsUNxYyM8BPXwNCaHgyTHNi5BJxk4+e4/Koc13DFcSxO4HC+R6c66XaOkbjByd08yOnyzQLVDaju5WdTI34M4LDrihEd+BS8uYyOOOReLGefUUxBE1bRguzErwk/z1pIia2eJgisHAzgnfamrsXcA8cGfZKggU0vARRVmuW8lncqhBDoxHyO1E7a4W5tlfbcYPl4GjP2kaeBqSug3cUt2wgtVVIS7KwAcvjdvKrRlqM8o5JkuLjYkx/wCYnSrP7G6suo6aqs39WH2G9OlVbGzLIJQT7OQ2OoxRjs9qw0rWA7ErDJhZB5HcN8OfzotCst5a91wt5RIgYYweWDXcYoYJohq0Njp0s1zbtIFQnwqsWfjQjHPfFWH2z1Q/4UbVLgt94YIc/wBo3P5VW/GBnG3SpQW9NGh7s7o8eqmVX3UNgjyIFWRa6X3NpBDsI4V4VB5n18aTvs6KuZwOanf5VZpjy8Kk+yzUs29wtCKzTT6Qhs4kKAnY5pY1nsbDNfLcsHyOQXp6VYF1lQoX8K1CWUSqQwB6UieDfOiPe9njIwkZAqj8S7Y8qg2GdJ1JASQuSMnkQaf7hfYIGw8qTO0ttwoZFHtKQfjn/mjujfGLTj2vhOo3EAjQuVQk48Kq++LQXrQjOISSCRzq0F1zTdPsjPqMrd6YxwIi5Z6rHVpDd31xdheFZHJC+A/mKtVpmuazSZbThowTuMYPmKyeT+mrKfaj5nO+PH4UMtpTHv8AhJHwqYX4SHXl1z0qxDS1OwWs/ebJLeRslV/pt6c1+Gx9CKdAcgVSXZG/ay1EW+QFkYPCSeUg5D4glfiPCritrhZ7eOWI8SOoZT4iuFZUXbFu6vJk4gRCRCu/M82P/wAilQnOetF+0s5muVJbPFxSc/7mJH0xQxIyDGvVjkjrSpYPod7D6qun64sMzhVuAEyTyfmPzxVxTsLi1jCShHUgg55Gg32f2dnLocVmEV0YNIzFRliT1/nSpesaVm1AjWWRAdnBwyY6ZHSs9jTZqqTzAnbaffSnilvmQf6QMEUQeCKBFWMk8Pj1qv4o5onH/wC67RhyBYbfSmHT7m7ZCbi6EoHIFME/GpmmdXx3QtMwxS1rwVhwsee9Fbq+RQSdsUqapem4eRifYUHJFGJKT4JmtDvZyh35IvpvUC4ROBjzAcrRfU1Ibv2GOFuID4UEtZ1EPdyjJLcRHnWuJjkiD3TJxdVB3Fd4QCnC26+maIdwt3xtEAFYEkfWosEJWKR8bRthvOmE8PVqjJIoY4HONh+9P1p2ku7O3SGMAru3jux4j9TSXath14QCrHZW3GaaraOBrdC8QzjpmuCK2vaZcW166yxkcIGDjY42qDblS4yQSM4pwW1upbVl1K4jll5J3eSPU5xW7DsvHfwTvAr8cfQgAsfSoxui3iZR1SitkTfsov5Bql7aynChFZd/XP6VZUiyyaSgtiBLz4jyqrNFtLqyvRPZ2jGSNSsw4/fXyB3zVhaT2gtHhEXeqGxujbMvkRSWRe6PXJIhG6t47jubiFt8sGMZIHQjPLnXO51G0iBECszf2opNNMF3bSLgED0rcwhlGNjmp4W+kytru7kumZd0XPLrUK74Y7JoGIVscI86PdpLNLe9Dpsr5yfMUFe2lu1KqB3YH4htRXBWKuo6opsTbspNxyz0x4fKgjRkgMp4G/OrG7P/AGfy69LPcyMbWKI4XcMZD4jy/wCqJy/ZccEF+QyW4OQ+daorhmlJbhXGnFh7u5U5ODmvBnEd8yuv9OVeHlT/AG/YDuNSis+/bLAFt+WRmic/YGxt2y8L3KRsGPte0Rtnam6K2ivuz+lXV2S/dslsgJaZhhSPU7UZgsr25jEsKuUJOCnunBxt8qdpdH7OKve8KRqPdgEzNv4CPP0xU2x7P3U9qsxhMXeEsECn2QSSBttQYNEKSe2AIV+JjyJOadPs/tvvHZ+eZkDHvzxnHgBVTXroYbQPtMsy7EbsvEDn6kVcv2Yd4NJvY5MBBesEx1BVP1zWaquKepFrbJSj1m9T0V0kF9p6ATKMtGOUg/eoJs4NTi72NcOuzKRupp7VVA7qRT7OwI50A1fTZLef7/YAGQf5sY5SD08a04ZtF5rCWIZjdl26HrRPRJnaMGXOfE1MZ4ZbMXMe6FeIeXl60O0lmEAJPSo2rMLUtvdPerWsF5MqTx8SDBwCR+VFbDQNMaFCsO2x3Y/lUKOJrm54R73ASPhU+zuJYG4JCdvGmrSaBbJpk6JYbS4zGFjxkYUY2qa1yLgLGgwpO/mKFySqctwfM120pzL30p90HgX9asQIPArdr4weqZ/2mp9wqtdyDOMdaFSy8HbG2IOxCj6Gicb8VwXK5Eh28gK4LOtppsDzCaaNWI3XiH1og0yk+8B5VFkuMLMU3JxGuKkxw2yIFlRHce8T41wD54vNMufuEl6bVBEsWTKSucDB23z0q4OwcXB2djcDBlnkb/dgflVcNcmXs/PaKgz3UiMx888vmKtPsjHjsxYDlxRcf/tv+tQrL2cTDUmJVV/Go1zHxITn2gM5rpFJjZ+THB8mrU0W2UJB8D1q5EQ9Za4tL2a3jYxwytx8AG243+dSbEcMWPStdqInF7BK2SnuenOultsmKzXPpppX5JlhMkGowtI2FOVJ9eVMF5Zq6d4g360ja8M2EvtFcLnIPLG9BbDVbyJMJeXCrkHAkOMcuXwp6nwS1ax8lR1DAjYdRUmLht7GNXbgTm7AdSaTU1O+b2GumyeWQDn6V7l1a/ZCj3BKkYI4R+1V0k4sJ3siRdpLV42yuU3z5mmK74YZYynu4IHz/wCvnSAkjs6vxHiT3T4U26BL/iGiFOMm4tJMYJ3K/h+mR8PKuTOa4T4LpMl88QQnHr416M7yEvht6AWc+ZymfZ4sD57UdVk4RueVEBVei2xntbxywCxtv47r/wAVbehwC20awgH/AI7aNfkorKyoU+FbvSTMmFMg3/uB6ivHGQoOSVPLPOt1lWIir2nbiu4U6bn15VGiLKoVeH1Of3rKys1j/RsqWxI2qJx27cRySMelLUsXcOpBHCdiPI1usp6vBLFjCFqwlhBI3XauxGd6ysqhM1GMEmulteTadc/eIHI2w652ZfCsrK449210018ZD+I5wNhvvyoybiVzxcWM1lZTCH//2Q==";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          GenreSlider(),
          blockImage(),
          slideimage(),
          blockTitle(),
          blockIcon(),
          blockText()
        ]),
      ),
    );
  }

  blockImage() {
    return Image.asset(
        "assets/images/103130337_999338717135285_1507870928285828698_n.jpg");
  }

  blockTitle() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "Nguyen Dang Quang",
              style: TextStyle(fontSize: 20),
            ),
            Text("Dep trai con hoc gioi")
          ]),
          Row(
            children: [
              Icon(
                Icons.star,
                color: Colors.red,
              ),
              Text("41")
            ],
          )
        ],
      ),
    );
  }

  blockIcon() {
    return DefaultTextStyle(
        style: TextStyle(color: Colors.blue),
        child: Container(
          margin: EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Icon(Icons.phone, color: Colors.blue),
                  Text("Phone")
                ],
              ),
              Column(
                children: [
                  Icon(Icons.near_me, color: Colors.blue),
                  Text("Phone")
                ],
              ),
              Column(
                children: [
                  Icon(Icons.share, color: Colors.blue),
                  Text("Phone")
                ],
              )
            ],
          ),
        ));
  }

  blockText() {
    return Container(
      margin: EdgeInsets.all(20),
      child: Text(
          "dajsdhaskldjaskdjaskldjsakdjsadsadjjjjjjdhsajhdsajkdhajsdhasjkdhsajdhasjkdhasjkdhasjkdhsajdhsakjdhasjdhsajkdhaskjdhsajkdhasjkdhasjdhasjdhkaskldjsadsakldjaksldjsakfljsafjhasjfsahjfshflashfasjlfa"),
    );
  }
}
